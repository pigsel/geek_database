import requests
import json
import time


URL = 'https://5ka.ru/api/v2/special_offers/'
headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36 OPR/67.0.3575.53'}

CAT_URL = 'https://5ka.ru/api/v2/categories/'

def cat_links():
    url_list = []
    categories = requests.get(CAT_URL, headers=headers)
    cat_dict = categories.json()
    for i in range(len(cat_dict)):
        cat_dict[i].get('parent_group_name')


def x5ka(url):
    result = []
    while url:
        response = requests.get(url, headers=headers)
        data = response.json()
        result.extend(data.get('results'))
        url = data.get('next')
        time.sleep(1)
    return result

if __name__ == '__main__':
     #data = x5ka(URL)
     cat_links()