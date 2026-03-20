# 🧸 ChinaMedia

## 前言

![](https://shields.io/badge/-移除重复规则-ff69b4) ![](https://shields.io/badge/-DOMAIN与DOMAIN--SUFFIX合并-green) ![](https://shields.io/badge/-DOMAIN--SUFFIX间合并-critical) ![](https://shields.io/badge/-DOMAIN--SUFFIX与DOMAIN--KEYWORD合并-blue) ![](https://shields.io/badge/-IP--CIDR(6)合并-blueviolet) 

ChinaMedia规则由《RULE GENERATOR 规则生成器》自动生成。

分流规则是互联网公共服务的域名和IP地址汇总，所有数据均收集自互联网公开信息，不代表我们支持或使用这些服务。

请通过【中华人民共和国 People's Republic of China】合法的互联网出入口信道访问规则中的地址，并确保在使用过程中符合相关法律法规。

## 规则统计

最后更新时间：2026-03-20 02:21:26

各类型规则统计：
| 类型 | 数量(条)  | 
| ---- | ----  |
| DOMAIN | 67  | 
| DOMAIN-KEYWORD | 2  | 
| DOMAIN-SUFFIX | 252  | 
| IP-CIDR | 55  | 
| IP-CIDR6 | 29  | 
| USER-AGENT | 35  | 
| TOTAL | 440  | 


## Loon 

#### 文件区别
- ChinaMedia_Resolve.list与ChinaMedia.list的区别仅在于后者IP-CIDR(6)类型带no-resolve。

#### 配置建议
- ChinaMedia.list 单独使用。
- ChinaMedia_Resolve.list 单独使用。

#### 规则链接
**MASTER分支 (每日更新)**

https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Loon/ChinaMedia/ChinaMedia.list

**MASTER分支 CDN (每日更新)**

https://cdn.jsdelivr.net/gh/blackmatrix7/ios_rule_script@master/rule/Loon/ChinaMedia/ChinaMedia.list

**MASTER分支 GHProxy (每日更新)**

https://ghproxy.com/https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Loon/ChinaMedia/ChinaMedia.list

**RELEASE分支 (不定时更新)**

https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/release/rule/Loon/ChinaMedia/ChinaMedia.list

**RELEASE分支CDN (不定时更新)**

https://cdn.jsdelivr.net/gh/blackmatrix7/ios_rule_script@release/rule/Loon/ChinaMedia/ChinaMedia.list

**RELEASE分支 GHProxy (不定时更新)**

https://ghproxy.com/https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/release/rule/Loon/ChinaMedia/ChinaMedia.list

## 子规则/排除规则

当前分流规则，已包含以下子规则，除非特殊需求否则不建议重复引用：
| 子规则  |  | 
| ---- | ----  |
| BiliBili | CCTV  | 


## 数据来源

《ChinaMedia》的数据来自以下链接，如与本项目的《ChinaMedia》规则混合使用，可能会造成规则大量重复。

- https://raw.githubusercontent.com/LM-Firefly/Rules/master/Domestic-Services/BiliBili.list
- https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/CCTV.list
- https://raw.githubusercontent.com/LM-Firefly/Rules/master/Domestic-Services/CCTV.list
- https://raw.githubusercontent.com/sve1r/Rules-For-Quantumult-X/develop/Rules/Media/DomesticMedia.list
- https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/Bilibili.list
- https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Providers/Ruleset/Bilibili.yaml
- https://raw.githubusercontent.com/zqzess/rule_for_quantumultX/master/QuantumultX/rules/CMedia.list
- https://ruleset.isagood.day/bilibili.conf


感谢以上规则作者的辛勤付出（排名不分先后）。

## 最后

### 感谢

[@fiiir](https://github.com/fiiir) [@Tartarus2014](https://github.com/Tartarus2014) [@zjcfynn](https://github.com/zjcfynn) [@chenyiping1995](https://github.com/chenyiping1995) [@vhdj](https://github.com/vhdj)

提供规则数据源及改进建议。

### 其他

请不要对外宣传本项目。