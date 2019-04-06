Attribute VB_Name = "TOOL_WRITE_CSV"
Option Explicit
Option Base 0

Function write_csv(filepath As String, rng As Range, Optional sep As String = ",", Optional endl As String = vbNewLine)
' Ecrit un range en format CSV
' https://docs.microsoft.com/fr-fr/office/vba/language/reference/user-interface-help/freefile-function
' By default, Excel VBA passes arguments by reference
' L'ecriture se fait en une seule fois
    Dim content As String: content = ""
    Dim i_min As Long: i_min = rng.Row
    Dim i_max As Long: i_max = rng.Rows.Count + i_min - 1
    Dim j_min As Long: j_min = rng.Column
    Dim j_max As Long: j_max = rng.Columns.Count + j_min - 1
    Dim i, j As Long
    
    Dim file_number As Integer: file_number = FreeFile(1) ' Option 1 permet que le fichier soit utilisable pendant l'écriture
    
    ' Récupération du contenu de la sélection (la boucle a été dupliqué pour éviter les tests de fin de lignes, plus coûteux en opérations)
    For i = i_min To i_max - 1   ' pour les lignes
        For j = j_min To j_max - 1 ' pour les colonnes
            content = content & CStr(rng.Cells(i, j).Value) & sep
        Next j
        content = content & CStr(rng.Cells(i, j_max).Value) & endl
    Next i
    ' Cas de la dernière ligne
    For j = j_min To j_max - 1 ' pour les colonnes
        content = content & CStr(rng.Cells(i_max, j).Value) & sep
    Next j
    content = content & CStr(rng.Cells(i_max, j_max).Value)
    
    ' Ecriture du fichier de sortie
    Open filepath For Output As #file_number
        Print #file_number, content ' Ecriture du fichier (Write met des quotations)
    Close #file_number
End Function
