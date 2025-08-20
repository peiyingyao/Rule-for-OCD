#!/usr/bin/env bash
set -euo pipefail

BASE_URL="http://127.0.0.1:8080/Clash"
LOCAL_DIR="./rule/Clash"
ts() { date +"%Y-%m-%d %H:%M:%S"; }

cd "$LOCAL_DIR" || exit 1

fix_cidr_in_file() {
    local file="$1"
    # 修复缺少 CIDR 的 IP-CIDR (IPv4)
    sed -i -E 's/^(IP-CIDR,([0-9]{1,3}(\.[0-9]{1,3}){3}))(,no-resolve)$/\1\/24\4/' "$file"
    # 修复缺少 CIDR 的 IP-CIDR6 (IPv6)
    sed -i -E 's/^(IP-CIDR6,([0-9a-fA-F:]+))(,no-resolve)$/\1\/128\3/' "$file"
}

download_and_check() {
    local output_file=$1
    local expected_md5=$2
    local url=$3
    local output_text_file=$4

    if wget -q --no-proxy -O "$output_file" "$url"; then
        local actual_md5
        actual_md5=$(md5sum "$output_file" | awk '{print $1}')
        if [[ "$actual_md5" == "$expected_md5" ]]; then
            rm -f "$output_file"
        else
            mv -f "$output_file" "$output_text_file"
        fi
    else
        echo "❌ 下载失败: $url" >&2
    fi
}

# .list -> .txt/.yaml
echo "[$(ts)] 开始: list -> txt/yaml 阶段"
find . -type f -name "*.list" | while IFS= read -r file; do
    fix_cidr_in_file "$file"
    RAW_URL="$BASE_URL/${file#./}"
    RAW_URL_BASE64=$(printf '%s' "$RAW_URL" | openssl base64 -A)

    OUTPUT_FILE_DOMAIN_YAML="${file%.list}_OCD_Domain.yaml"
    OUTPUT_FILE_DOMAIN_TEXT="${file%.list}_OCD_Domain.txt"
    OUTPUT_FILE_IP_YAML="${file%.list}_OCD_IP.yaml"
    OUTPUT_FILE_IP_TEXT="${file%.list}_OCD_IP.txt"

    # type=3 域名, type=4 IP
    download_and_check "$OUTPUT_FILE_DOMAIN_YAML" \
        "0c04407cd072968894bd80a426572b13" \
        "http://127.0.0.1:25500/getruleset?type=3&url=$RAW_URL_BASE64" \
        "$OUTPUT_FILE_DOMAIN_TEXT"

    download_and_check "$OUTPUT_FILE_IP_YAML" \
        "3d6eaeec428ed84741b4045f4b85eee3" \
        "http://127.0.0.1:25500/getruleset?type=4&url=$RAW_URL_BASE64" \
        "$OUTPUT_FILE_IP_TEXT"
done
echo "[$(ts)] 结束: list -> txt/yaml 阶段"

# .txt -> .mrs
echo "[$(ts)] 开始: txt -> mrs 阶段"
find . -type f -name "*_OCD_*.txt" | while IFS= read -r file; do
    if head -n1 "$file" | grep -q "payload"; then
        sed -i '1d' "$file"
    fi
    # 清理字符
    sed -i "s/'//g; s/-//g; s/[[:space:]]//g" "$file"

    filename=$(basename "$file" .txt)
    file_dir=$(dirname "$file")

    case "$filename" in
        *_OCD_Domain*) param="domain" ;;
        *_OCD_IP*)     param="ipcidr" ;;
        *) echo "⚠️ 未识别的文件类型: $file" >&2; continue ;;
    esac

    output_file="$file_dir/$filename.mrs"
    log_file="$file_dir/$filename.mrs.log"

    if /usr/bin/mihomo convert-ruleset "$param" text "$file" "$output_file" >"$log_file" 2>&1; then
        echo "✅ 转换成功: $output_file"
        rm -f "$log_file"   # 成功就删除日志文件，避免目录里多余文件
    else
        echo "❌ 转换失败: $file, 日志见 $log_file" >&2
    fi
done
echo "[$(ts)] 结束: txt -> mrs 阶段"
