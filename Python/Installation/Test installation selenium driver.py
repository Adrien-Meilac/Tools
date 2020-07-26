# -*- coding: utf-8 -*-
"""
Created on Mon May 18 18:11:43 2020

@author: AMEILAC
"""


from selenium import webdriver

browser = webdriver.Firefox()
browser.get('https://www.google.co.in')

browser = webdriver.Chrome()
browser.get('https://www.google.co.in')
