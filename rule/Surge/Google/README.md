# 🧸 Google

## 前言

![](https://shields.io/badge/-移除重复规则-ff69b4) ![](https://shields.io/badge/-DOMAIN与DOMAIN--SUFFIX合并-green) ![](https://shields.io/badge/-DOMAIN--SUFFIX间合并-critical) ![](https://shields.io/badge/-DOMAIN--SUFFIX与DOMAIN--KEYWORD合并-blue) ![](https://shields.io/badge/-IP--CIDR(6)合并-blueviolet) 

Google规则由《RULE GENERATOR 规则生成器》自动生成。

分流规则是互联网公共服务的域名和IP地址汇总，所有数据均收集自互联网公开信息，不代表我们支持或使用这些服务。

请通过【中华人民共和国 People's Republic of China】合法的互联网出入口信道访问规则中的地址，并确保在使用过程中符合相关法律法规。

## 规则说明
不含有Youtube分流规则

## 规则统计

最后更新时间：2026-05-12 02:38:11

各类型规则统计：
| 类型 | 数量(条)  | 
| ---- | ----  |
| DOMAIN | 1  | 
| DOMAIN-KEYWORD | 5  | 
| DOMAIN-SUFFIX | 684  | 
| IP-CIDR | 4  | 
| IP-CIDR6 | 1  | 
| PROCESS-NAME | 5  | 
| USER-AGENT | 3  | 
| TOTAL | 703  | 


## Surge 

#### 使用说明
- Google.list，请使用RULE-SET。
- Google_Resolve.list，请使用RULE-SET。

#### 文件区别
- Google_Resolve.list与Google.list的区别仅在于后者IP-CIDR(6)类型带no-resolve。

#### 配置建议
- Google.list 单独使用。
- Google_Resolve.list 单独使用。

#### 规则链接
**MASTER分支 (每日更新)**

https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Google/Google.list

**MASTER分支 CDN (每日更新)**

https://cdn.jsdelivr.net/gh/blackmatrix7/ios_rule_script@master/rule/Surge/Google/Google.list

**MASTER分支 GHProxy (每日更新)**

https://ghproxy.com/https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Google/Google.list

**RELEASE分支 (不定时更新)**

https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/release/rule/Surge/Google/Google.list

**RELEASE分支CDN (不定时更新)**

https://cdn.jsdelivr.net/gh/blackmatrix7/ios_rule_script@release/rule/Surge/Google/Google.list

**RELEASE分支 GHProxy (不定时更新)**

https://ghproxy.com/https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/release/rule/Surge/Google/Google.list

## 子规则/排除规则

当前分流规则，已包含以下子规则，除非特殊需求否则不建议重复引用：
| 子规则  |  |  | 
| ---- | ---- | ----  |
| GoogleDrive | GoogleSearch | GoogleVoice  | 


当前分流规则，已排除以下规则：
| 排除规则  |  | 
| ---- | ----  |
| YouTube | YouTubeMusic  | 

## 数据来源

《Google》的数据来自以下链接，如与本项目的《Google》规则混合使用，可能会造成规则大量重复。

- https://raw.githubusercontent.com/Loyalsoldier/surge-rules/release/ruleset/google.txt
- https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/source/rule/Google/Google.list
- https://raw.githubusercontent.com/sve1r/Rules-For-Quantumult-X/develop/Rules/Services/Google.list
- https://raw.githubusercontent.com/LM-Firefly/Rules/master/PROXY/Google.list
- https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/google.txt
- https://raw.githubusercontent.com/LM-Firefly/Rules/master/Clash-RuleSet-Classical/PROXY/Google.yaml
- https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Ruleset/Google.list
- https://raw.githubusercontent.com/ACL4SSR/ACL4SSR/master/Clash/Providers/Ruleset/Google.yaml


感谢以上规则作者的辛勤付出（排名不分先后）。

## 最后

### 感谢

[@fiiir](https://github.com/fiiir) [@Tartarus2014](https://github.com/Tartarus2014) [@zjcfynn](https://github.com/zjcfynn) [@chenyiping1995](https://github.com/chenyiping1995) [@vhdj](https://github.com/vhdj)

提供规则数据源及改进建议。

### 其他

请不要对外宣传本项目。