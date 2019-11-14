# -*- coding: utf-8 -*-

import os
root = r"C:\Users\AMEILAC\OneDrive\Documents\2019 - ENSAE 3A\S1\Apprentissage Statistique Appliqué"
os.chdir(root)

from PyPDF2 import PdfFileMerger

pdfs = ['Note de cours 1 - 7.pdf',
 'Notes de cours 8 - 14.pdf',
 'Notes de cours p15 - 19.pdf']

merger = PdfFileMerger()

for pdf in pdfs:
    merger.append(pdf)

merger.write("result.pdf")
merger.close()
