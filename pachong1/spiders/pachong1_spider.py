import os

import requests
import scrapy
import pandas as pd
from pachong1.items import Pachong1Item


class Pachong1SpiderSpider(scrapy.Spider):
    name = 'pachong1_spider'
    # 爬域
    allowed_domains = ['movie.douban.com']
    # allowed_domains = ['114.116.228.245:7321']
    # 入口url
    start_urls = ['https://movie.douban.com/top250']

    # start_urls = ['http://114.116.228.245:7321/dist']

    def parse(self, response):
        # print(response.text)

        df_list = []
        movie_list = response.xpath("//div[@class='article']//ol[@class='grid_view']/li")
        for item in movie_list:
            # print(item)
            douban_item = Pachong1Item()
            douban_item["serial_number"] = item.xpath(".//div[@class='item']//em/text()").extract_first()
            douban_item["movie_name"] = item.xpath(
                ".//div[@class='info']//div[@class='hd']/a/span[1]/text()").extract_first()
            content = item.xpath(".//div[@class='info']//div[@class='bd']/p[1]/text()").extract()
            for i_con in content:
                content_s = "".join(i_con.split())
            douban_item["introduce"] = content_s
            # print(douban_item["movie_name"])
            douban_item["star"] = item.xpath(".//span[@class=rating_num]/text()").extract_first()
            douban_item["evaluate"] = item.xpath(".//div[@class='star']/span[4]/text()").extract_first()
            douban_item["describe"] = item.xpath(".//p[@class='quote']/span/text()").extract_first()

            yield douban_item
        next_link = response.xpath("//span[@class='next']/link/@href").extract()
        if next_link:
            next_link = next_link[0]
            yield scrapy.Request("https://movie.douban.com/top250"+next_link,callback=self.parse)
