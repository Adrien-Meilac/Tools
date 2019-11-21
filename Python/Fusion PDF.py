# -*- coding: utf-8 -*-

import os
root = r"C:\Users\AMEILAC\OneDrive\Documents\2019 - ENSAE 3A\S1\Financial Econometrics"
os.chdir(root)

from PyPDF2 import PdfFileMerger

pdfs = ['Notes p1 à 11.pdf',
 '18112019120720.pdf']

merger = PdfFileMerger()

for pdf in pdfs:
    merger.append(pdf)

merger.write("Notes 1 - 16.pdf")
merger.close()
