#!/usr/local/bin/x-python/bin/python

import os
import time
import json
import pytz
import requests as r
from datetime import datetime
from bs4 import BeautifulSoup
from html2text import html2text


if "VZ_CONFL_DATA" not in os.environ:
    raise Exception("Env var VZ_CONFL_DATA not defined")
if "VZ_CONFL_INDEX" not in os.environ:
    raise Exception("Env var VZ_CONFL_INDEX not defined")
if "VZ_CONFL_TOKEN" not in os.environ:
    raise Exception("Env var VZ_CONFL_TOKEN not defined")

DATA_PATH = os.environ['VZ_CONFL_DATA']
INDEX_FILE = os.environ['VZ_CONFL_INDEX']
TOKEN = open(os.environ['VZ_CONFL_TOKEN'], "r", encoding="utf-8").read()

HOST = "https://wiki.mos-team.ru"
PAGE_URL = f"{HOST}/pages/viewpage.action?pageId="
HEADERS = {
    "Authorization": f"Bearer {TOKEN}",
    "Accept": "application/json",
    "Content-Type": "application/json"
}
LIMIT = 200
perm = pytz.timezone("Asia/Yekaterinburg")


def update_pages(pages_data, last_update):
    updated_keys = []
    offset = 0
    last_modified = str(last_update).split()[0]
    while True:

        print(f"(confluence-crawl) [{str(datetime.now()).split('.')[0]}] /search: start={offset}")
        res = r.get(f"{HOST}/rest/api/latest/search?limit={LIMIT}&start={offset}&expand=content.body.export_view&"+
            f"cql=space+%3D+%22EHDW2%22+and+type+%3D+%22page%22+and+lastmodified+%3E%3D+%22{last_modified}%22", headers=HEADERS)
        if res.status_code != 200:
            raise Exception(f"(confluence-crawl) GET /search returned code {res.status_code}")
        data = json.loads(res.text)

        results = data["results"]
        print(f"(confluence-crawl) response 200: returned {len(results)} pages, total {data["totalSize"]}")
        for result in results:
            if datetime.fromisoformat(result["lastModified"]).astimezone(perm) <= last_update:
                return pages_data, updated_keys
            else:
                one_liner_parts = []
                file_parts = []
                
                page_id = result["content"]["id"]
                
                one_liner_parts.append(page_id)
                
                one_liner_parts.append(result["title"])
                file_parts.append(f"\n> # {result["title"]}")

                html = result["content"]["body"]["export_view"]["value"]

                soup = BeautifulSoup(html, 'html.parser')
                text = soup.get_text(separator=' ', strip=True)
                one_liner_parts.append(text)

                file_parts.append(html2text(html))

                one_liner_parts.append(f"{DATA_PATH}/{page_id}.md")
                one_liner_parts.append(f"|{PAGE_URL}{page_id}")

                one_liner = " ".join(one_liner_parts).replace('\n', ' ').replace('\r','') + "\n"
                file_body = "\n".join(file_parts)
                
                pages_data[page_id] = (one_liner, file_body)
                updated_keys.append(page_id)
    
        if offset + len(results) >= data["totalSize"]:
            break
        else:
            offset = offset + len(results)

        time.sleep(2)

    return pages_data, updated_keys



if __name__ == "__main__":
    pages_data = {}

    if not os.path.exists(DATA_PATH):
        os.mkdir(DATA_PATH)
    
    if not os.path.exists(INDEX_FILE):
        last_update = datetime(1000, 1, 1, 0, 0, 0, 0)
    else:
        with open(INDEX_FILE, 'r', encoding="utf-8") as f:
            last_update = datetime.fromisoformat((str(next(f)).strip('\n')))
            for line in f:
                pages_data[line.split()[0]] = (line, None)

    last_update = last_update.astimezone(perm)
    update_start = datetime.now().astimezone(perm)
    print(f"(confluence-crawl) Started updating at {str(update_start).split(".")[0]}")
    print(f"(confluence-crawl) Last update {str(last_update).split(".")[0]}")

    pages_data, updated_keys = update_pages(pages_data, last_update)

    if len(updated_keys) > 0:
        with open(INDEX_FILE, 'w', encoding="utf-8") as f:
            f.write(str(update_start)+'\n')
            for k, v in pages_data.items():
                f.write(f"{v[0]}")
            
        for k in updated_keys:
            with open(f"{DATA_PATH}/{k}.md", "w", encoding="utf-8") as f:
                f.write(pages_data[k][1])
        print(f"(confluence-crawl) Updated {len(updated_keys)} pages in {DATA_PATH}")
    
    else:
        print("(confluence-crawl) Pages not changed sinse last update")
        