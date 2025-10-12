#!/usr/local/bin/x-python/bin/python

import os
import time
import json
import pytz
import requests as r
from datetime import datetime
from jira2markdown import convert
from markdown import markdown
from bs4 import BeautifulSoup



# Путь к файлу с описанием задач
# DATA_PATH = os.environ['VZ_JIRA_TASKS']
DATA_PATH = os.environ['VZ_JIRA_DATA']
INDEX_FILE = os.environ['VZ_JIRA_INDEX']
if not DATA_PATH:
    raise Exception("Env var VZ_JIRA_DATA not defined")
if not INDEX_FILE:
    raise Exception("Env var VZ_JIRA_INDEX not defined")
# Токен для Jira
TOKEN = open(os.environ['VZ_JIRA_TOKEN'], "r", encoding="utf-8").read()


HOST = "https://task.mos-team.ru"
TAKS_URL = f"{HOST}/browse"
HEADERS = {
    "Authorization": f"Bearer {TOKEN}",
    "Accept": "application/json",
    "Content-Type": "application/json"
}
LIMIT = 500
perm = pytz.timezone("Asia/Yekaterinburg")


def search(offset):
    payload = json.dumps({
        "fields": [
            "summary",
            "description",
            "comment",
            "created",
            "updated",
            "resolution",
            "parent",
            "creator",
            "assignee",
            "issuetype",
            "status",
            "components",
            "fixVersions",
            "labels",
            "priority"
        ],
        "maxResults": LIMIT,
        "startAt": offset,
        "jql": "project = GISEHD order by updated DESC"
    })

    print(f"(jira-crawl) [{str(datetime.now()).split('.')[0]}] /search: startAt={offset}")
    res = r.post(f"{HOST}/rest/api/latest/search", headers=HEADERS, data=payload)
    if res.status_code != 200:
        raise Exception(f"(jira-crawl) POST /search returned code {res.status_code}")
    return json.loads(res.text)


def update_tasks(tasks_data, last_update):
    updated_keys = []
    offset = 0
    while True:
        data = search(offset)

        issues = data["issues"]
        print(f"(jira-crawl) response 200: returned {len(issues)} issues, total {data["total"]}")
        for issue in issues:
            fields = issue["fields"]
            if datetime.fromisoformat(fields["updated"]).astimezone(perm) <= last_update:
                return tasks_data, updated_keys
            else:
                one_liner_parts = []
                file_parts = []

                one_liner_parts.append(issue["key"])
                
                one_liner_parts.append("Title")
                one_liner_parts.append(fields["summary"])

                if "parent" in fields and fields["parent"]:
                    one_liner_parts.append("Parent")
                    one_liner_parts.append(fields["parent"]["key"])
                    one_liner_parts.append(fields["parent"]["fields"]["summary"])

                    file_parts.append(f"`{fields["parent"]["key"]}`  {fields["parent"]["fields"]["summary"]} / `{issue["key"]}`")

                else:
                    file_parts.append(f"`{issue["key"]}`")

                file_parts.append(f"\n# {fields["summary"]}")
                
                if "description" in fields and fields["description"]:
                    desc = convert(fields["description"])
                    one_liner_parts.append("\nDescription")
                    html = markdown(desc)

                    soup = BeautifulSoup(html, 'html.parser')
                    text = soup.get_text(separator=' ', strip=True)
                    one_liner_parts.append(text)

                if "assignee" in fields and fields["assignee"]:
                    one_liner_parts.append("Assignee")
                    one_liner_parts.append(fields["assignee"]["displayName"])
                    file_parts.append(f"\n\n> `Исполнитель` {fields["assignee"]["displayName"]}")

                if "creator" in fields and fields["creator"]:
                    one_liner_parts.append("Creator")
                    one_liner_parts.append(fields["creator"]["displayName"])
                    file_parts.append(f"> `Автор` {fields["creator"]["displayName"]}")
                    
                if "issuetype" in fields and fields["issuetype"]:
                    one_liner_parts.append("IssueType")
                    one_liner_parts.append(fields["issuetype"]["name"])
                    file_parts.append(f"> `Тип` {fields["issuetype"]["name"]}")
                    
                if "status" in fields and fields["status"]:
                    one_liner_parts.append("Status")
                    one_liner_parts.append(fields["status"]["name"])
                    file_parts.append(f"\n\n> `Статус` {fields["status"]["name"]}")

                if "resolution" in fields and fields["resolution"]:
                    one_liner_parts.append("Resolution")
                    one_liner_parts.append(fields["resolution"]["name"])
                    file_parts.append(f"> `Решение` {fields["resolution"]["name"]}")
                    
                if "priority" in fields and fields["priority"]:
                    one_liner_parts.append("Priority")
                    one_liner_parts.append(fields["priority"]["name"])
                    file_parts.append(f"> `Приоритет` {fields["priority"]["name"]}")
                    
                if "fixVersions" in fields and fields["fixVersions"]:
                    one_liner_parts.append("FixVersions")
                    for ver in fields["fixVersions"]:
                        one_liner_parts.append(ver["name"])
                    file_parts.append("\n\n> `Релизы` " + ", ".join([''+ver['name']+'' for ver in fields["fixVersions"]]))

                if "components" in fields and fields["components"]:
                    one_liner_parts.append("Components")
                    for com in fields["components"]:
                        one_liner_parts.append(com["name"])
                    file_parts.append("> `Компоненты` " + ", ".join([''+com['name']+'' for com in fields["components"]]))
                    
                if "labels" in fields and fields["labels"]:
                    one_liner_parts.append("Labels")
                    for l in fields["labels"]:
                        one_liner_parts.append(l)
                    file_parts.append("> `Метки` " + ", ".join([''+l+'' for l in fields["labels"]]))
                
                one_liner_parts.append("Created")
                created_dt = str(datetime.fromisoformat(fields["created"]).astimezone(perm)).split("+")[0]
                one_liner_parts.append(created_dt)
                one_liner_parts.append("Updated")
                updated_dt = str(datetime.fromisoformat(fields["updated"]).astimezone(perm)).split("+")[0]
                one_liner_parts.append(updated_dt)

                file_parts.append(f"\n\n> `Дата обновления` {updated_dt}")
                file_parts.append(f"> `Дата создания` {created_dt}")

                
                file_parts.append(f"\n---")
                if "description" in fields and fields["description"]:
                    file_parts.append(f"\n{desc}")
                file_parts.append(f"\n---")

                if "comment" in fields and fields["comment"]:
                    issue_comment = fields["comment"]
                    if "comments" in issue_comment and issue_comment["comments"]:
                        for com in issue_comment["comments"]:
                            file_parts.append(f"\n\n`{com["author"]["displayName"]}` {str(datetime.fromisoformat(com["created"]).astimezone(perm)).split(".")[0]}\n")
                            file_parts.append(convert(com["body"]))
                            file_parts.append("\n---\n")


                one_liner_parts.append(f"{DATA_PATH}/{issue["key"]}.md")
                one_liner_parts.append(f"{TAKS_URL}/{issue["key"]}")
                
                one_liner = " ".join(one_liner_parts).replace('\n', '').replace('\r', '') + "\n"
                file_body = "\n".join(file_parts)

                tasks_data[issue["key"]] = (one_liner, file_body)
                updated_keys.append(issue["key"])
    
        if offset + len(issues) >= data["total"]:
            break
        else:
            offset = offset + len(issues)

    return tasks_data, updated_keys


if __name__ == "__main__":
    tasks_data = {}

    if not os.path.exists(DATA_PATH):
        os.mkdir(DATA_PATH)
    if not os.path.exists(INDEX_FILE):
        last_update = datetime(1000, 1, 1, 0, 0, 0, 0)
    else:
        with open(INDEX_FILE, 'r', encoding="utf-8") as f:
            last_update = datetime.fromisoformat((str(next(f)).strip('\n')))
            for line in f:
                tasks_data[line.split()[0]] = (line, None)

    last_update = last_update.astimezone(perm)
    update_start = datetime.now().astimezone(perm)
    print(f"(jira-crawl) Started updating at {str(update_start).split(".")[0]}")
    print(f"(jira-crawl) Last update {str(last_update).split(".")[0]}")

    tasks_data, updated_keys = update_tasks(tasks_data, last_update)

    if len(updated_keys) > 0:
        with open(INDEX_FILE, 'w', encoding="utf-8") as f:
            f.write(str(update_start)+'\n')
            for k, v in tasks_data.items():
                f.write(f"{v[0]}")

        for k in updated_keys:
            with open(f"{DATA_PATH}/{k}.md", "w", encoding="utf-8") as f:
                f.write(tasks_data[k][1])
        print(f"(jira-crawl) Updated {len(updated_keys)} tasks in {DATA_PATH}")
    
    else:
        print("(jira-crawl) Tasks have not changed sinse last update")
