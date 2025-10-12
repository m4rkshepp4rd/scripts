#!/usr/local/bin/x-python/bin/python

# TODO локально сохранять всю информацию, при изменении обновлять локальную дату обновлений 

import subprocess
import ast
import datetime
import os
from os import path
from os import listdir
from hashlib import sha256

HOME = path.expanduser('~')
DATE_NAME = ".gnome-menu-sync-date"
MENU_STATE_NAME = '.gnome-menu-state'
DATE_LOCAL_PATH = f"{HOME}/.config/{DATE_NAME}"
STATE_LOCAL_PATH = f"{HOME}/.config/{MENU_STATE_NAME}"

GM_PATH = f"{os.environ['MS_CFG']}/etc/gnome-menu"
if not GM_PATH:
    raise Exception("Env var MS_CFG not defined")
FA_PATH = f'{GM_PATH}/.favorite-apps'
APL_FOLDERS_PATH = f'{GM_PATH}/.folders'
DATE_PATH = f'{GM_PATH}/{DATE_NAME}'
STATE_PATH = f'{GM_PATH}/{MENU_STATE_NAME}'

FAV = "FAV"


def execcmd(cmdstr, print_out=False):
    out = subprocess.check_output(cmdstr, shell=True).decode()
    if out and print_out:
        print(out)
    return out


def parse_apl(apl):
    if '{' not in apl:
        apl=''
    parsed_lists = []
    screens_data = apl.replace('@a{sv} {}, ', '').split(', {')
    for scr in screens_data:
        scr_list = []
        elements_data = scr.split(',')
        for el in elements_data:
            el_name = el.split(':')[0].lstrip('[').lstrip(' ').lstrip("{").lstrip("'").rstrip("'")
            if el_name != '':
                scr_list.append(el_name)
        if len(scr_list) > 0:
            parsed_lists.append(scr_list)
    return parsed_lists


def combine_apps(favorite_apps, pages, folders):
    apps = {}
    for fa in favorite_apps:
        apps[fa] = FAV
    for i,page in pages.items():
        for pa in page:
            apps[pa] = i
    for fld,app_list in folders.items():
        for a in app_list:
            apps[a] = fld
    return apps


def sync_lists(list_local, list_cloud, all_local, from_cloud, debug_str=None):
    if debug_str:
        print()
        print('(gnome-menu) ' + debug_str)
        print('(gnome-menu) list_local', list_local)
        print('(gnome-menu) list_cloud', list_cloud)

    synced_list = []
    for li in list_local:
        if li not in synced_list:
            if li in list_cloud and from_cloud:
                for bi in list_cloud[:list_cloud.index(li)]:
                    if bi not in synced_list and (bi in all_local or not all_local):
                        synced_list.append(bi)
            if li not in synced_list:
                synced_list.append(li)
    if from_cloud:
        for li in list_cloud:
            if li not in synced_list and (li in all_local or not all_local):
                synced_list.append(li)
    
    if debug_str:
        print('(gnome-menu) synced_list', synced_list)
    return synced_list


def form_layout(lists):
    pages = []
    for ll in lists:
        pages.append(', '.join([f"'{li}': <{{'position': <{i}>}}>" for i,li in enumerate(ll)]))
    layout=f"[{', '.join([f'{{{p}}}' for p in pages])}]"
    if layout == "[]":
        layout = "['']"
    return layout


def get_local_state(fa_local, apl_folders_local, app_picker_layout_local, folders_local):
    return sha256((str(fa_local)+str(apl_folders_local)+str(app_picker_layout_local)+str(folders_local)).encode()).hexdigest()



assert path.exists(GM_PATH)

# Считаем локальное состояние менюшки, если изменилось - меняем
try:
    fa_local = ast.literal_eval(execcmd("dconf read /org/gnome/shell/favorite-apps"))
except:
    fa_local = []
app_picker_layout_local = execcmd("dconf read /org/gnome/shell/app-picker-layout")
apl_local = parse_apl(app_picker_layout_local)
# apl_folders_local = ast.literal_eval(execcmd("gsettings get org.gnome.desktop.app-folders folder-children"))
apl_folders_local = []
pages_local = {}
for i,page in enumerate(apl_local):
    pages_local[f'.page{i}'] = page
    for item in page:
        if '.desktop' not in item:
            apl_folders_local.append(item)

folders_local_str = ''
for fld in apl_folders_local:
    try:
        folders_local_str = folders_local_str + str(execcmd(f"dconf read /org/gnome/desktop/app-folders/folders/{fld}/apps"))
        folders_local_str = folders_local_str + str(execcmd(f"dconf read /org/gnome/desktop/app-folders/folders/{fld}/name"))
    except:
        pass

local_state = get_local_state(fa_local, apl_folders_local, app_picker_layout_local, folders_local_str)


# Определяем последние даты обновления и состояния в облаке и локально
if path.exists(DATE_LOCAL_PATH):
    with open(DATE_LOCAL_PATH, 'r', encoding='utf-8') as f:
        date_local = datetime.datetime.fromisoformat(f.read())
else:
    print('(gnome-menu) No local update date saved!')
    date_local = datetime.datetime.now()

if path.exists(DATE_PATH):
    with open(DATE_PATH, 'r', encoding='utf-8') as f:
        date_cloud = datetime.datetime.fromisoformat(f.read())
else:
    print('(gnome-menu) No update date in cloud')
    date_cloud = date_local

# Убедились, что состояния есть и локально, и в облаке (при этом локальное обновляем)
if not path.exists(STATE_LOCAL_PATH):
    print('(gnome-menu) No local state saved!')
    with open(STATE_LOCAL_PATH, 'w', encoding='utf-8') as f:
        f.write(local_state)
else:
    with open(STATE_LOCAL_PATH, 'r', encoding='utf-8') as f:
        current_state = f.read()
    if current_state != local_state:
        print('(gnome-menu) Local state changed!')
        with open(STATE_LOCAL_PATH, 'w', encoding='utf-8') as f:
            f.write(local_state)
        date_local = datetime.datetime.now()
        with open(DATE_LOCAL_PATH, 'w', encoding='utf-8') as f:
            f.write(str(date_local))


if path.exists(STATE_PATH):
    with open(STATE_PATH, 'r', encoding='utf-8') as f:
        current_state_cloud = f.read()
else:
    print('(gnome-menu) No state in cloud! kostyl')
    current_state_cloud = sha256("kostyl".encode()).hexdigest()

# В какую сторону синхронизировать, если локально первый раз, то берем за основу облако
from_cloud = date_local < date_cloud
if not path.exists(DATE_LOCAL_PATH) and path.exists(DATE_PATH):
    from_cloud = True

# Если состояние отличается от облака, синхронизируем
if current_state_cloud != local_state:
    print('(gnome-menu) Cloud and local states are different!')
    if from_cloud:
        print('(gnome-menu) Updating from cloud...')
    else:
        print('(gnome-menu) Updating to cloud...')

    try:
        fa_cloud = ast.literal_eval(open(FA_PATH, 'r', encoding='utf-8').read())
    except:
        print(f'Could not read {FA_PATH}')
        fa_cloud = []

    try:
        apl_folders_cloud = ast.literal_eval(open(APL_FOLDERS_PATH, 'r', encoding='utf-8').read())
    except:
        print(f'(gnome-menu) Could not read {APL_FOLDERS_PATH}')
        apl_folders_cloud = []

    apl_folders_synced = sync_lists(apl_folders_local, apl_folders_cloud, apl_folders_local+apl_folders_cloud, from_cloud, 'folders')

    # # Потеряшки - приложения, со 2й страницы и дальше
    # try:
    #     lost_cloud = ast.literal_eval(open(LOST_PATH, 'r', encoding='utf-8').read())
    # except:
    #     print(f'Could not read {LOST_PATH}')
    #     lost_cloud = []
    # lost_local = list(itertools.chain.from_iterable(parsed_apl_local[1:]))

    pages_cloud = {}
    if path.exists(GM_PATH):
        for f in listdir(GM_PATH):
            if f.startswith('.page'):
                pages_cloud[f] = ast.literal_eval(open (f'{GM_PATH}/{f}', 'r', encoding='utf-8').read())
    ll = len(pages_local)
    lc = len(pages_cloud)
    for i in range(max(ll, lc)):
        if i+1 > ll:
            pages_local[f'.page{i}'] = []
        if i+1 > lc:
            pages_cloud[f'.page{i}'] = []


    # Для каждой папки смотрим список приложений и вытаскиваем в отдельные списки
    folders_local = {}
    folders_cloud = {}
    folder_names_local = {}
    folder_names_cloud = {}
    folder_names_synced = {}
    for fld in apl_folders_synced:
        try:
            fld_apps_cloud = ast.literal_eval(open(f'{GM_PATH}/{fld}', 'r', encoding='utf-8').read())
            fld_name_cloud = open(f'{GM_PATH}/{fld}.name', 'r', encoding='utf-8').read()
        except:
            print(f'(gnome-menu) Could not read {GM_PATH}/{fld}, assuming it is empty')
            fld_apps_cloud = []
            fld_name_cloud = fld
        if fld in apl_folders_local:
            try:
                fld_apps_local = ast.literal_eval(execcmd(f"dconf read /org/gnome/desktop/app-folders/folders/{fld}/apps"))
            except:
                fld_apps_local = []
            try:
                fld_name_local = ast.literal_eval(execcmd(f"dconf read /org/gnome/desktop/app-folders/folders/{fld}/name"))
            except:
                fld_name_local = fld
        else:
            fld_apps_local = []
            fld_name_local = fld
        folders_local[fld] = fld_apps_local
        folders_cloud[fld] = fld_apps_cloud
        folder_names_local[fld] = fld_name_local
        folder_names_cloud[fld] = fld_name_cloud
        # folders_synced[fld] = sync_lists(fld_apps_local, fld_apps_cloud, from_cloud)
        folder_names_synced[fld] = fld_name_cloud if from_cloud else fld_name_local
    
    # Удаляем за GNOME приложения отовсюду, если они закреплены 
    for fa in fa_local:
        for page in pages_local.values():
            if fa in page:
                page.remove(fa)
        for fld in folders_local.values():
            if fa in fld:
                fld.remove(fa)

    # Небольшая магия по синхронизации
    apps_local = combine_apps(fa_local, pages_local, folders_local)
    apps_cloud = combine_apps(fa_cloud, pages_cloud, folders_cloud)

    for app,place_cloud in apps_cloud.items():
        if (app in apps_local) and (place_cloud != apps_local[app]):
            if from_cloud:
                if apps_local[app] == FAV:
                    fa_local.remove(app)
                elif apps_local[app].startswith('.page'):
                    for page in pages_local.values():
                        if app in page:
                            page.remove(app)
                else:
                    folders_local[apps_local[app]].remove(app)
            else:
                if place_cloud == FAV:
                    fa_cloud.remove(app)
                elif place_cloud.startswith('.page'):
                    for page in pages_cloud.values():
                        if app in page:
                            page.remove(app)
                else:
                    folders_cloud[place_cloud].remove(app)

    folders_synced = {}
    empty_folders = []
    for fld in apl_folders_synced:
        fld_synced = sync_lists(folders_local[fld], folders_cloud[fld], apps_local, from_cloud, f'folder {folder_names_synced[fld]} {fld}')
        folders_synced[fld] = fld_synced
        if len(fld_synced) == 0:
            empty_folders.append(fld)
    for emtfld in empty_folders:
        apl_folders_synced.remove(emtfld)
        try:
            execcmd(f"rm {GM_PATH}/{emtfld}", print_out=True)
        except:
            pass
        try:
            execcmd(f"rm {GM_PATH}/{emtfld}.name", print_out=True)
        except:
            pass
        for page in pages_local.values():
            if emtfld in page:
                page.remove(emtfld)

    for fld in apl_folders_cloud:
        if fld not in apl_folders_synced:
            try:
                execcmd(f"rm {GM_PATH}/{fld}", print_out=True)
            except:
                pass
            try:
                execcmd(f"rm {GM_PATH}/{fld}.name", print_out=True)
            except:
                pass

    # folders_synced = {}
    # for app,place in apps_local.items():
    #     if place not in [FAV, LOST]:
    #         if place not in folders_synced:
    #             folders_synced[place] = []
    #         folders_synced[place].append(app)

    fa_synced = sync_lists(fa_local, fa_cloud, apps_local, from_cloud, 'favorite')

    pages_new_local = []
    pages_new_cloud = []
    pages_synced = []
    for i in range(max(ll,lc)):
        if pages_local[f'.page{i}'] != []:
            pages_new_local.append(pages_local[f'.page{i}'])
        if pages_cloud[f'.page{i}'] != []:
            pages_new_cloud.append(pages_cloud[f'.page{i}'])
    ll = len(pages_new_local)
    lc = len(pages_new_cloud)
    for i in range(max(ll, lc)):
        if i+1 > ll:
            pages_new_local.append([])
        if i+1 > lc:
            pages_new_cloud.append([])
    for i in range(max(ll, lc)):
        page_synced = sync_lists(pages_new_local[i], pages_new_cloud[i], list(apps_local.keys())+apl_folders_synced, from_cloud, f'page{i}')
        if len(page_synced) > 0:
            pages_synced.append(page_synced)
    


    # Обновляем настройки, пишем в облако, если переносим в облако
    if not path.exists(GM_PATH):
        execcmd(f"mkdir -p {GM_PATH}", print_out=True)


    execcmd(f'gsettings set org.gnome.shell favorite-apps "{str(fa_synced)}"', print_out=True)
    with open(FA_PATH, 'w', encoding='utf-8') as f:
        f.write(str(fa_synced))

    execcmd(f'gsettings set org.gnome.desktop.app-folders folder-children "{str(apl_folders_synced)}"', print_out=True)
    with open(APL_FOLDERS_PATH, 'w', encoding='utf-8') as f:
        f.write(str(apl_folders_synced))

    for fld in apl_folders_synced:
        execcmd(f'dconf write /org/gnome/desktop/app-folders/folders/{fld}/name "\'{folder_names_synced[fld]}\'"', print_out=True)
        if len(folders_synced[fld]) == 0:
            execcmd(f'dconf write /org/gnome/desktop/app-folders/folders/{fld}/apps "\'[]\'"', print_out=True)
        else:
            execcmd(f'dconf write /org/gnome/desktop/app-folders/folders/{fld}/apps "{str(folders_synced[fld])}"', print_out=True)
        with open(f'{GM_PATH}/{fld}', 'w', encoding='utf-8') as f:
            f.write(str(folders_synced[fld]))
        with open(f'{GM_PATH}/{fld}.name', 'w', encoding='utf-8') as f:
            f.write(str(folder_names_synced[fld]))

    execcmd(f'dconf write /org/gnome/shell/app-picker-layout "{form_layout(pages_synced)}"', print_out=True)
    for i,page in enumerate(pages_synced):
        with open(f'{GM_PATH}/.page{i}', 'w', encoding='utf-8') as f:
            f.write(str(page))
    for i in range(len(pages_cloud)):
        if i+1 > len(pages_synced):
            try:
                execcmd(f"rm {GM_PATH}/.page{i}", print_out=True)
            except:
                pass

    # Пересчитываем локальное состояние
    try:
        fa_local_new = ast.literal_eval(execcmd("dconf read /org/gnome/shell/favorite-apps"))
    except:
        fa_local_new = []
    app_picker_layout_local_new = execcmd("dconf read /org/gnome/shell/app-picker-layout")
    apl_local = parse_apl(app_picker_layout_local_new)
    # apl_folders_local = ast.literal_eval(execcmd("gsettings get org.gnome.desktop.app-folders folder-children"))
    apl_folders_local_new = []
    pages_local = {}
    for i,page in enumerate(apl_local):
        pages_local[f'.page{i}'] = page
        for item in page:
            if '.desktop' not in item:
                apl_folders_local_new.append(item)

    folders_local_str_new = ''
    for fld in apl_folders_local_new:
        try:
            folders_local_str_new = folders_local_str_new + str(execcmd(f"dconf read /org/gnome/desktop/app-folders/folders/{fld}/apps"))
            folders_local_str_new = folders_local_str_new + str(execcmd(f"dconf read /org/gnome/desktop/app-folders/folders/{fld}/name"))
        except:
            pass

    local_state_new = get_local_state(fa_local_new, apl_folders_local_new, app_picker_layout_local_new, folders_local_str_new)
    state_synced = current_state_cloud if from_cloud else local_state_new

    # Приравниваем время синхронизации и сохраняем состония
    with open(STATE_PATH, 'w', encoding='utf-8') as f:
        f.write(state_synced)
    with open(STATE_LOCAL_PATH, 'w', encoding='utf-8') as f:
        f.write(local_state_new)

    current_time = datetime.datetime.now()
    with open(DATE_PATH, 'w', encoding='utf-8') as f:
        f.write(str(current_time))
    with open(DATE_LOCAL_PATH, 'w', encoding='utf-8') as f:
        f.write(str(current_time))


    if from_cloud:
        print('(gnome-menu) Updated from cloud...')
    else:
        print('(gnome-menu) Updated to cloud...')
