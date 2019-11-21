# -*- coding: utf-8 -*-

import PyPDF2

inputpath = r"C:\Users\AMEILAC\OneDrive\Documents\2019 - ENSAE 3A\S1\Valorisation et couverture de produits dérivés\Notes 1 - 19.pdf"
outputpath = r"C:\Users\AMEILAC\OneDrive\Documents\2019 - ENSAE 3A\S1\Valorisation et couverture de produits dérivés\Notes 1 - 19 - C.pdf"
SelectPageToRotate = [27 - 1] # Attention, la numérotation des pages commence à zéro !!

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
