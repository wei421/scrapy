import os

import requests
import scrapy
import pandas as pd
from pachong1.items import Pachong1Item


class Pachong1SpiderSpider(scrapy.Spider):
    name = 'pachong1_spider'
    #爬域
    allowed_domains = ['movie.douban.com']
    # allowed_domains = ['114.116.228.245:7321']
    #入口url
    start_urls = ['http://core.ecu.edu/psyc/wuenschk/PP/PP-Stats.htm']
    # start_urls = ['http://114.116.228.245:7321/dist']

    def parse(self, response):
        # print(response.text)
        end_pos = self.start_urls[0].rfind('/')
        prefix_url = self.start_urls[0][:end_pos + 1]

        df_list = []
        file_list = response.xpath("//ul/li")
        for item in file_list:
        #     print(item)
            douban_item = Pachong1Item()
            douban_item['name'] = item.xpath(".//p/a[1]/text()").extract_first()
            # douban_item['introduce'] = item.xpath(".//div[@class='item']/div[@class='info']/div[@class='hd']/a/span[@class='title']/text()").extract_first()
            tmp_url = item.xpath(".//p/a[1]/@href").extract_first()
            if tmp_url == None:
                continue
            douban_item['url'] = tmp_url if 'http' in tmp_url else prefix_url + tmp_url
            if 'http' not in tmp_url:
                douban_item['fname'] = tmp_url
            else:
                start_pos = tmp_url.rfind('/')+1
                # print(tmp_url)
                douban_item['fname'] = tmp_url[start_pos:]
            if 'htm' in douban_item['fname']:
                continue
            intro_list = item.xpath(".//p/text()").extract()
            douban_item['introduce'] = ''
            for i in intro_list:
                douban_item['introduce'] += i.replace('--','').replace('\r','').replace('\n','').replace('\t','')


            df_list.append(douban_item)
            # print(douban_item)
        df = pd.DataFrame(df_list)
        df['idx'] = df.index.values
        df['fname'] = df['idx'].map(str) + '.' + df['fname']
        df = df.drop(['idx'], axis=1)
        dpath = os.path.join(os.path.abspath(os.path.dirname(os.path.dirname(__file__))),'downloads')
        if not os.path.exists(dpath):
            os.makedirs(dpath)
        for i in range(df.shape[0]):
            print(os.path.join(dpath,df['fname'][i]))
            r = requests.get(df['url'][i])
            with open(os.path.join(dpath,df['fname'][i]), 'wb') as f:
                f.write(r.content)

        df.to_excel(os.path.join(dpath,'目录.xlsx'))
            # print("hehe")
        #     yield douban_item
        # next_link = response.xpath("//span[@class='next']/link/@href").extract()
        # if next_link:
        #     next_link=next_link[0]
        #     yield scrapy.Request(self.start_urls[0] + next_link,callback=self.parse)