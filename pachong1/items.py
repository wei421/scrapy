# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class Pachong1Item(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    # pass

    #名字
    name = scrapy.Field()
    #介绍
    introduce = scrapy.Field()
    #url
    url = scrapy.Field()
    #文件名
    fname = scrapy.Field()
