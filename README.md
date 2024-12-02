# Rule for OCD

> `OCD` 是强迫症的意思，Obsessive–compulsive disorder

Stash 是 Clash 在 Apple 设备上的实现，其[文档](https://stash.wiki/rules/rule-set "https://stash.wiki/rules/rule-set")说明: "不建议使用内含大量规则的 classical 规则集合，会显著提高 Stash 内存占用，降低规则匹配速度。"，"domain(-text) 和 ipcidr(-text) 两种类型的规则集合专门针对大量数据进行了优化，在规则条目较多时建议优先选择。"

Stash 作为 GUI 客户端，个人猜想作者大概率没有闲工夫为内核做优化，如果猜想为真，那么使用 Clash 内核时，最佳实践是使用 domain 和 ipcidr 的 rule-set(text)，至少应避免使用 classical

找到了 Clash 作者 Dreamacro 的[原话](https://web.archive.org/web/20221116130342/https://github.com/Dreamacro/clash/issues/1165 "https://web.archive.org/web/20221116130342/https://github.com/Dreamacro/clash/issues/1165")

> classical 是朴素的规则，支持其他所有的 rule，但由于整个 rule 是一起的，所以当包含需要解析 dns 的规则时，整个 rule 被视为需要 dns 解析，所以要对 classical 做适当拆分（当然如果不在乎 dns 解析忽略即可）
>
> ipcidr 和 domain 是对大量的 ipcidr 和域名规则做优化，能在有大量规则的同时还保持着很快的匹配速度，当然这是以牺牲内存为代价换来的匹配速度（以目前的实现来说，几十万的规则大概占用几十兆内存）。台式机不在乎那点内存，但一些性能受限的设备可能很在乎。

有人曾向 ios_rule_script 作者 blackmatrix7 提出了[调整拆分阈值的请求](https://github.com/blackmatrix7/ios_rule_script/issues/569#issuecomment-1131664794 "https://github.com/blackmatrix7/ios_rule_script/issues/569#issuecomment-1131664794")，blackmatrix7 考虑到最终用户可能会被太多的文件混淆就婉拒了

另外 Mihomo/Clash.Meta 有独有的 mrs 格式，[能够减少加载时硬件资源占用](https://github.com/MetaCubeX/mihomo/issues/1494#issuecomment-2328193689 "https://github.com/MetaCubeX/mihomo/issues/1494#issuecomment-2328193689")，也能减少一半以上文件大小

Just do it.

现在每个 `<name>.list` 文件被拆分为 `<name>_OCD_Domain.mrs`、`<name>_OCD_IP.mrs`、`<name>_OCD_Domain.txt`、`<name>_OCD_IP.txt`、`<name>_OCD_Domain.yaml` 和 `<name>_OCD_IP.yaml`

例如 `Apple.list`，对应 `Apple_OCD_Domain.mrs`、`Apple_OCD_IP.mrs`、`Apple_OCD_Domain.txt`、`Apple_OCD_IP.txt`、`Apple_OCD_Domain.yaml` 和 `Apple_OCD_IP.yaml`，链接：[https://github.com/peiyingyao/Rule-for-OCD/tree/master/rule/Clash/Apple](https://github.com/peiyingyao/Rule-for-OCD/tree/master/rule/Clash/Apple)

具体实现均在 `.github/workflows/convert_rules.yaml` 和 `script/convert_rules.sh`

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

# Rules And Scripts

## 前言

各平台的分流规则、复写规则及自动化脚本。

## 特别声明

1. 本项目内所有资源文件，禁止任何公众号、自媒体进行任何形式的转载、发布。
2. 编写本项目主要目的为学习和研究ES6，无法保证项目内容的合法性、准确性、完整性和有效性。
3. 本项目涉及的数据由使用的个人或组织自行填写，本项目不对数据内容负责，包括但不限于数据的真实性、准确性、合法性。使用本项目所造成的一切后果，与本项目的所有贡献者无关，由使用的个人或组织完全承担。
4. 本项目中涉及的第三方硬件、软件等，与本项目没有任何直接或间接的关系。本项目仅对部署和使用过程进行客观描述，不代表支持使用任何第三方硬件、软件。使用任何第三方硬件、软件，所造成的一切后果由使用的个人或组织承担，与本项目无关。
5. 本项目中所有内容只供学习和研究使用，不得将本项目中任何内容用于违反国家/地区/组织等的法律法规或相关规定的其他用途。
6. 所有基于本项目源代码，进行的任何修改，为其他个人或组织的自发行为，与本项目没有任何直接或间接的关系，所造成的一切后果亦与本项目无关。
7. 所有直接或间接使用本项目的个人和组织，应24小时内完成学习和研究，并及时删除本项目中的所有内容。如对本项目的功能有需求，应自行开发相关功能。
8. 本项目保留随时对免责声明进行补充或更改的权利，直接或间接使用本项目内容的个人或组织，视为接受本项目的特别声明。

## 规则

**我们并不生产规则，我们只是开源规则的搬运工。**

分流规则

https://github.com/blackmatrix7/ios_rule_script/tree/master/rule

复写规则

https://github.com/blackmatrix7/ios_rule_script/tree/master/rewrite

所有规则数据都来自互联网，感谢开源规则项目作者的辛勤付出。

## 脚本

### 脚本说明

| 脚本                                                         | 介绍                                 | 框架        | 维护状态 |
| ------------------------------------------------------------ | ------------------------------------ | ----------- | -------- |
| [什么值得买](https://github.com/blackmatrix7/ios_rule_script/tree/master/script/smzdm) | 什么值得买任务和去广告               | MagicJS 2/3 | 正常     |
| [百度贴吧](https://github.com/blackmatrix7/ios_rule_script/tree/master/script/tieba) | 带重试功能的贴吧签到，提高签到成功率 | MagicJS 3   | 正常     |
| [开屏去广告](https://github.com/blackmatrix7/ios_rule_script/tree/master/script/startup) | 通过脚本去除缓存到本地的APP开屏广告  | MagicJS 3   | 正常     |
| [慢慢买](https://github.com/blackmatrix7/ios_rule_script/tree/master/script/manmanbuy) | 每日自动签到                         | MagicJS 2   | 正常     |
| [叮咚买菜](https://github.com/blackmatrix7/ios_rule_script/tree/master/script/dingdong) | 每日自动签到                         | MagicJS 3   | 正常     |
| [Fa米家](https://github.com/blackmatrix7/ios_rule_script/tree/master/script/famijia) | 每日自动签到                         | MagicJS 2   | 正常     |
| [Luka](https://github.com/blackmatrix7/ios_rule_script/tree/master/script/luka) | 每日自动签到                         | MagicJS 2   | 正常     |
| [哲也同学](https://github.com/blackmatrix7/ios_rule_script/tree/master/script/zheye) | 之乎者也                             | MagicJS 3   | 正常     |
| [Synology](https://github.com/blackmatrix7/ios_rule_script/tree/master/script/synology) | 群晖Download Station资源离线下载     | MagicJS 3   | 正常     |
| [AppleStore](https://github.com/blackmatrix7/ios_rule_script/tree/master/script/applestore) | AppleStore 商品库存监控              | MagicJS 3   | 暂停     |

#### Quantumult X Gallery

部分脚本已配置为Quantumult X Gallery。

地址： https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/script/gallery.json

#### BoxJS

感谢 [@chouchoui](https://github.com/chouchoui) 为本项目添加BoxJS的订阅。

地址：https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/script/boxjs.json

### 外部资源

项目中资源来自互联网上其他开源项目（具体以不同目录的说明为准），这里主要进行一些整合和备份。对于此类资源，无法对使用过程中出现的任何问题进行解答，您需要联系原作者。

地址：https://github.com/blackmatrix7/ios_rule_script/tree/master/external

# 感谢

以下排名不分先后

[@BaileyZyp](https://github.com/BaileyZyp)   [@Mazeorz](https://github.com/Mazeorz)   [@LuzMasonj](https://github.com/LuzMasonj)  [@chouchoui](https://github.com/chouchoui)  [@ypannnn](https://github.com/ypannnn)  [@echizenryoma](https://github.com/echizenryoma)  [@zirawell](https://github.com/zirawell)  [@urzz](https://github.com/urzz)  [@ASD-max](https://github.com/ASD-max)

