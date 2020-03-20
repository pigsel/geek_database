import requests
import json
import time
import os

URL = 'https://5ka.ru/api/v2/special_offers/'
headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36 OPR/67.0.3575.53'}
CAT_URL = 'https://5ka.ru/api/v2/categories/'

if not os.path.exists('j_data'):
    os.makedirs('j_data')                # make a directory 'j_data'

def get_products(url, params):
    result = []
    while url:
        response = requests.get(url, headers=headers, params=params) if params else requests.get(url, headers=headers)
        params = None
        data = response.json()
        result.extend(data.get('results'))
        url = data.get('next')
        time.sleep(1)
    return result


def clear_name(name: str) -> str:
    tmp = name.replace('*', '').replace(',', '').replace('"', '').lower().split()
    return '_'.join(tmp)


if __name__ == '__main__':
    categories = requests.get(CAT_URL, headers=headers).json()

    for category in categories:
        category['products'] = get_products(URL, {'records_per_page': 100,
                                                  'categories': category['parent_group_code']
                                                  }
                                            )

        with open(f'j_data/{clear_name(category["parent_group_name"])}.json', 'w') as file:
            file.write(json.dumps(category))
