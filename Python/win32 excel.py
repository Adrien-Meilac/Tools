# -*- coding: utf-8 -*-
"""
Created on Fri Sep 11 22:08:25 2020

@author: AMEILAC
"""

import win32com.client

excelapp = win32com.client.Dispatch("Excel.Application")
excelapp.Visible = True
workbook = excelapp.Workbooks.Add()

for sheet in workbook.Sheets:
    print(sheet.Name)

sheet = workbook.Worksheets(1)
sheet.Name = "Feuille n°1"
sheet.Color = 'blue'

workbook.Sheets.Add(Before = sheet) # Or After = sheet
print(workbook.Sheets.Count)

sheet.Tab.ColorIndex = 10

workbook.SaveAs(r'C:\Users\AMEILAC\Desktop\UpdatedSheet.xlsx')
workbook.Close()
excelapp.Quit()
