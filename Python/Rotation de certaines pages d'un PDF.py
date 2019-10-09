# -*- coding: utf-8 -*-

import PyPDF2

inputpath = r"C:\Users\AMEILAC\OneDrive\Documents\2017 - ENSAE 2A\S2\Introduction au machine learning\Cours\Notes.pdf"
outputpath = r"C:\Users\AMEILAC\OneDrive\Documents\2017 - ENSAE 2A\S2\Introduction au machine learning\Cours\Notes2.pdf"
SelectPageToRotate = [] # Attention, la numérotation des pages commence à zéro !!

pdf_in = open(inputpath, 'rb')
pdf_reader = PyPDF2.PdfFileReader(pdf_in)
pdf_writer = PyPDF2.PdfFileWriter()

for pagenum in range(pdf_reader.numPages):
    page = pdf_reader.getPage(pagenum)
    if pagenum in SelectPageToRotate:
        page.rotateClockwise(180)
    pdf_writer.addPage(page)

pdf_out = open(outputpath, 'wb')
pdf_writer.write(pdf_out)
pdf_out.close()
pdf_in.close()
