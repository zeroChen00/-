# coding: utf-8

result = ""

target = 'calc' # 该处写上要执行的命令，例如calc 弹出计算器

for x in target:

result += hex(ord(x)) + ","

print(result.rstrip(','))