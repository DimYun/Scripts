from bs4 import BeautifulSoup
from itertools import count
import requests
import random
import os

# Select category
search_category = input('Type category: ')
order = input('Select order: 1=date_added, 2=random, 3=toplist, 4=favorites ')
shifr = {
        1: 'date_added',
        2: 'random',
        3: 'toplist',
        4: 'favorites'
        }
try:
    order = shifr[ind(order)]
except:
    order = 'random'
page_num = input('How many pages to download: ')
if search_category == '':
    url = "https://wallhaven.cc/search?categories=110&purity=110&resolutions=1920x1080&topRange=1M&sorting=toplist&order=desc&page="
else:
    url = "https://wallhaven.cc/search?q={0}&categories=111&purity=110&resolutions=1920x1080&sorting={1}&order=desc&page=".format(search_category, order)
# url = 'https://wallhaven.cc/search?q=id%3A479&categories=111&purity=110&resolutions=1920x1080&sorting=random&order=desc&seed=5fULT&page='
# url = 'https://wallhaven.cc/search?categories=010&purity=100&resolutions=1920x1080&topRange=1M&sorting=toplist&order=desc&colors=000000&page='
# url = 'https://wallhaven.cc/search?categories=110&purity=100&resolutions=1920x1080&topRange=1M&sorting=toplist&order=desc&page='
jpg = 'http://w.wallhaven.cc/full/%s/wallhaven-%s.jpg'
png = 'http://w.wallhaven.cc/full/%s/wallhaven-%s.png'

status = '\r[page {:0>3}] [image {:0>2}|24] [{:.<24}]'.format

all_wallpapers = []
counter = 0
path_to_folder = '/home/dmitriy/Desktop/Entertainments/Wallpapers/auto_download/'

# Clear source folder
c = 'rm ' + path_to_folder + '*-new_wall.*'
print(c)
os.system(c)

print('url is: ' + url)

#for f in os.listdir(path_to_folder):
#    print('Start remove old files:')
#    print('\t' + f)
#    os.remove(path_to_folder + '/' + f)
#    print('remove old files suсcessfully')



for i in range(1, int(page_num)+1):
    soup = BeautifulSoup(requests.get(url + str(i)).text)
    figs = soup.find_all('figure')
    for j, fig in enumerate(figs, 1):
        print(status(i, j, j*'#'))
        name = fig.find('a').get('href').rsplit('/', 1)[1]
        prefix = name[:2]
        all_wallpapers.append([prefix, name])
        r = requests.get(jpg % (prefix, name))
        if r.status_code == 404:
            r = requests.get(png % (prefix, name))
            name += '.png'
        else:
            name += '.jpg'
        with open(path_to_folder + str(counter) +  '-new_wall' + name[-4:], 'wb') as f:
            f.write(r.content)
        counter += 1

# prefix, name = random.choice(all_wallpapers)
# print('download url: ', jpg % (prefix, name))
# r = requests.get(jpg % (prefix, name))
# if r.status_code == 404:
#     r = requests.get(png % (prefix, name))
#     name += '.png'
# else:
#     name += '.jpg'
# with open('%03d-%02d-%s' % (i, j, name), 'wb') as f:
# with open('new_wall' + name[-4:], 'wb') as f:
#     f.write(r.content)
