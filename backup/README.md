# Rule for OCD

OCD 是强迫症的简称

## 背景

Stash 是 Clash 在 Apple 设备上的实现，其[文档](https://stash.wiki/rules/rule-set 'https://stash.wiki/rules/rule-set')说明：“不建议使用内含大量规则的 classical 规则集合，会显著提高 Stash 内存占用，降低规则匹配速度。”，“domain(-text) 和 ipcidr(-text) 两种类型的规则集合专门针对大量数据进行了优化，在规则条目较多时建议优先选择。”

Stash 作为 GUI 客户端，个人猜想作者大概率没有闲工夫为内核做优化，如果猜想为真，那么使用 Clash 内核时，最佳实践是使用 domain 和 ipcidr 的 rule-set(text)，至少应避免使用 classical

找到了原 Clash 作者 Dreamacro 的[原话](https://web.archive.org/web/20221116130342/https://github.com/Dreamacro/clash/issues/1165 'https://web.archive.org/web/20221116130342/https://github.com/Dreamacro/clash/issues/1165')

> classical 是朴素的规则，支持其他所有的 rule，但由于整个 rule 是一起的，所以当包含需要解析 dns 的规则时，整个 rule 被视为需要 dns 解析，所以要对 classical 做适当拆分（当然如果不在乎 dns 解析忽略即可）
>
> ipcidr 和 domain 是对大量的 ipcidr 和域名规则做优化，能在有大量规则的同时还保持着很快的匹配速度，当然这是以牺牲内存为代价换来的匹配速度（以目前的实现来说，几十万的规则大概占用几十兆内存）。台式机不在乎那点内存，但一些性能受限的设备可能很在乎。

有人曾向 ios_rule_script 作者 blackmatrix7 提出了[调整拆分阈值的请求](https://github.com/blackmatrix7/ios_rule_script/issues/569#issuecomment-1131664794 'https://github.com/blackmatrix7/ios_rule_script/issues/569#issuecomment-1131664794')，blackmatrix7 考虑到最终用户可能会被太多的文件混淆就婉拒了

另外 Mihomo/Clash.Meta 有独有的 mrs 格式，[能够减少加载时硬件资源占用](https://github.com/MetaCubeX/mihomo/issues/1494#issuecomment-2328193689 'https://github.com/MetaCubeX/mihomo/issues/1494#issuecomment-2328193689')，也能减少一半以上规则文件大小

## 结果

目前每个 .list 文件被拆分为 .mrs、.txt 和 .yaml

例如 Apple.list，对应：

- Apple_OCD_Domain.mrs
- Apple_OCD_IP.mrs
- Apple_OCD_Domain.txt
- Apple_OCD_IP.txt
- Apple_OCD_Domain.yaml
- Apple_OCD_IP.yaml

链接：[https://github.com/peiyingyao/Rule-for-OCD/tree/master/rule/Clash/Apple](https://github.com/peiyingyao/Rule-for-OCD/tree/master/rule/Clash/Apple)

## 如何使用

```yaml
rules:
  - RULE-SET,Lan_OCD_Domain,DIRECT
  - RULE-SET,Lan_OCD_IP,DIRECT,no-resolve
  - RULE-SET,Google_OCD_Domain,<你的首个 proxy-groups 名>
  - RULE-SET,Google_OCD_IP,<你的首个 proxy-groups 名>,no-resolve
rule-providers:
  Lan_OCD_Domain:
    type: http
    behavior: domain
    url: >-
      https://fastly.jsdelivr.net/gh/peiyingyao/Rule-for-OCD@master/rule/Clash/Lan/Lan_OCD_Domain.mrs
    # fastly.jsdelivr.net 可直连，但内容更新有 24 小时延迟，能排查错误可以选择 github 源:
    # https://raw.githubusercontent.com/peiyingyao/Rule-for-OCD/refs/heads/master/rule/Clash/Lan/Lan_OCD_Domain.mrs
    # proxy: <name> # 选择 github 源需要指定代理，填入一个 proxy-groups 或 proxies 名
    format: mrs # 如果用 .txt 则填 text
    path: ./rule-set/Lan_OCD_Domain.mrs
    interval: 86400 # 更新时间，单位为秒
  Lan_OCD_IP:
    type: http
    behavior: ipcidr
    url: >-
      https://fastly.jsdelivr.net/gh/peiyingyao/Rule-for-OCD@master/rule/Clash/Lan/Lan_OCD_IP.mrs
    format: mrs
    path: ./rule-set/Lan_OCD_IP.mrs
    interval: 86400
  Google_OCD_Domain:
    type: http
    behavior: domain
    url: >-
      https://fastly.jsdelivr.net/gh/peiyingyao/Rule-for-OCD@master/rule/Clash/Google/Google_OCD_Domain.mrs
    format: mrs
    path: ./rule-set/Google_OCD_Domain.mrs
    interval: 86400
  Google_OCD_IP:
    type: http
    behavior: ipcidr
    url: >-
      https://fastly.jsdelivr.net/gh/peiyingyao/Rule-for-OCD@master/rule/Clash/Google/Google_OCD_IP.mrs
    format: mrs
    path: ./rule-set/Google_OCD_IP.mrs
    interval: 86400
```
