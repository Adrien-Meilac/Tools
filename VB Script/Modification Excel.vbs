' Permet de modifier Excel avec pour défaut le calcul semi automatique
Set ExcelApp = CreateObject("Excel.Application")
ExcelApp.Visible = False  'or "False"
ExcelFilePath =  "C:\Users\UT2PC2\Desktop\Book1.xlsx" ' Chemin vers un fichier où le calcul est semi automatique
Set wb = ExcelApp.Workbooks.Open(ExcelFilePath)
wb.Close
ExcelApp.Visible = True