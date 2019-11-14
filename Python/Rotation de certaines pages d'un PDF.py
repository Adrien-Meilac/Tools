# -*- coding: utf-8 -*-

import PyPDF2

inputpath = r"C:\Users\AMEILAC\OneDrive\Documents\2019 - ENSAE 3A\S1\Autre\Calcul Stochastique\bbd1.pdf"
outputpath = r"C:\Users\AMEILAC\OneDrive\Documents\2019 - ENSAE 3A\S1\Autre\Calcul Stochastique\bbd2.pdf"
SelectPageToRotate = [44 + 1,46+ 1,47+ 1,48+ 1,
                      49+ 1,65+ 1,66+ 1,67+ 1,
                      68+ 1] # Attention, la numérotation des pages commence à zéro !!

pdf_in = open(inputpath, 'rb')
pdf_reader = PyPDF2.PdfFileReader(pdf_in)
pdf_writer = PyPDF2.PdfFileWriter()

for pagenum in range(pdf_reader.numPages):
    page = pdf_reader.getPage(pagenum)
    if pagenum in SelectPageToRotate:
        page.rotateClockwise(90)
    pdf_writer.addPage(page)

pdf_out = open(outputpath, 'wb')
pdf_writer.write(pdf_out)
pdf_out.close()
pdf_in.close()
