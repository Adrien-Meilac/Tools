Attribute VB_Name = "TOOL_EXPORT"
'Version 1 (2019-04-30)
'Contiens les fonctions
'   -> ExportCSV(String, Range)
'   -> WriteJSON(String, Dictionnary)

Option Explicit
Option Base 0

Public Function ExportCSV(filepath As String, _
                          rng As Range, _
                          Optional sep As String = ",", _
                          Optional endl As String = vbNewLine)
    ' Ecrit un range en format CSV
    ' https://docs.microsoft.com/fr-fr/office/vba/language/reference/user-interface-help/freefile-function
    ' L'ecriture se fait en une seule fois
    Dim content As String: content = ""
    Dim i, j As Long
    Dim file_number As Integer
    file_number = FreeFile(1) ' Option 1 permet que le fichier soit utilisable pendant l'écriture
        
    With rng
        Dim i_min As Long: i_min = .Row
        Dim i_max As Long: i_max = .Rows.Count + i_min - 1
        Dim j_min As Long: j_min = .column
        Dim j_max As Long: j_max = .Columns.Count + j_min - 1

        ' Récupération du contenu de la sélection
        ' La boucle a été dupliqué pour éviter les tests de fin de lignes, plus coûteux en opérations
        For i = i_min To i_max - 1   ' pour les lignes
            For j = j_min To j_max - 1 ' pour les colonnes
                content = content & CStr(.Cells(i, j).Value) & sep
            Next j
            content = content & CStr(.Cells(i, j_max).Value) & endl
        Next i
        ' Cas de la dernière ligne
        For j = j_min To j_max - 1 ' pour les colonnes
            content = content & CStr(.Cells(i_max, j).Value) & sep
        Next j
        content = content & CStr(.Cells(i_max, j_max).Value)
    End With
    
    ' Ecriture du fichier de sortie
    Open filepath For Output As #file_number
        Print #file_number, content ' Ecriture du fichier (Write met des quotations)
    Close #file_number
End Function

Public Function WriteJSON(filepath As String, _
                          d As Scripting.Dictionary)
    'Ecrit un JSON a partir d'un vecteur de champs et de valeurs
    Dim spaceBeforeEachElement As String
    Dim keys() As Variant: keys = d.keys()
    Dim items() As Variant: items = d.items()
    Dim i_min As Long: i_min = LBound(keys)
    Dim i_max As Long: i_max = UBound(keys)
    Dim i As Long
    
    Dim content As String
    
    content = "{" & vbNewLine
    For i = i_min To i_max
        content = content & vbTab & Chr(34) & keys(i) & Chr(34) & ": "
        If IsString(items(i)) Then
            content = content & Chr(34) & items(i) & Chr(34)
        ElseIf IsNumeric(items(i)) Then
            content = content & items(i)
        Else ' Array
            spaceBeforeEachElement = vbTab & Space$(5 + Len(keys(i)))
            
            If IsNumeric(items(i)(LBound(items(i)))) Then
                content = content & "[" & Join(items(i), "," & vbNewLine & spaceBeforeEachElement) & "]"
            Else
                content = content & "[" & Chr(34) & Join(items(i), Chr(34) & "," & vbNewLine & spaceBeforeEachElement & Chr(34)) & Chr(34) & "]"
            End If
        End If
        
        If i < i_max Then
            content = content & "," & vbNewLine
        Else
            content = content & vbNewLine
        End If
    Next i
    content = content & "}"
    
    Dim file As New ADODB.Stream
    With file
        .Type = 2 ' specify stream type - we want To save text/string data.
        .Charset = "utf-8" ' specify charset For the source text data.
        .Open ' open the stream And write binary data To the object
        .WriteText (content) ' writting the computation date and the corporate list
        Call .SaveToFile(filepath, 2) ' saving the file in a binary format
    End
    Set file = Nothing ' removing the object from the memory
End Function
