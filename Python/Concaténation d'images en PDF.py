# -*- coding: utf-8 -*-

from fpdf import FPDF
from PIL import Image

def makePdf(pdfFileName, listPages, dir = ''):
    if (dir):
        dir += "/"

    cover = Image.open(dir + str(listPages[0]) + ".jpg")
    width, height = cover.size

    pdf = FPDF(unit = "pt", format = [width, height])

    for page in listPages:
        pdf.add_page()
        pdf.image(dir + str(page) + ".jpg", 0, 0)

    pdf.output(dir + pdfFileName + ".pdf", "F")
    
    
#Autre solution :
#from PIL import Image
#
#im_list = []
#for l in L:
#    im_list.append(Image.open(l))
#
#pdf1_filename = "bbd1.pdf"
#
#im_list[0].save(pdf1_filename, "PDF" ,resolution=100.0, save_all=True, append_images=im_list[1:])