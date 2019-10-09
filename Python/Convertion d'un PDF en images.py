# -*- coding: utf-8 -*-

from pdf2jpg import pdf2jpg
inputpath = r"C:\Users\AMEILAC\OneDrive\Documents\2017 - ENSAE 2A\S2\Introduction au machine learning\Cours\Notes.pdf"
outputpath = r"C:\Users\AMEILAC\Desktop\Notes"

result = pdf2jpg.convert_pdf2jpg(inputpath, outputpath, pages = "ALL")
print(result)