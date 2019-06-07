Attribute VB_Name = "TOOL_IMPORT"
'Version 1 (2019-04-30)
'Contiens les fonctions
'   -> UpdateTableFromCSV(String, ListObject)
'   -> ExtractTableFromCSV(String, Range, String)
'   -> ExtractArrayFromCSV(String)

Option Explicit
Option Base 0

Function UpdateTableFromCSV(filepath As String, _
                             t As ListObject, _
                             Optional sep As String = ",", _
                             Optional replace As Boolean = False, _
                             Optional hasHeaders As Boolean = False)
    ' Extrait les données d'un CSV et les mets en tableau
    Call TableDeleteAllRows(t)
    
    Dim Data As Variant: Data = ExtractArrayFromCSV(filepath)
    Dim ncolumns As Long: ncolumns = UBound(Data)
    Dim nrows As Long: nrows = UBound(Data, 2)
    Dim i As Long, j As Long
    
    Call TableAddRows(t, nrows - ToInt(hasHeaders))
    
    If hasHeaders Then
        For j = 0 To ncolumns
            t.HeaderRowRange.Cells(1, j + 1) = Data(j, 0)
        Next j
    End If
    
    For i = 0 To nrows - ToInt(hasHeaders)
        For j = 0 To ncolumns
            t.DataBodyRange.Cells(i + 1, j + 1) = Data(j, i + ToInt(hasHeaders))
        Next j
    Next i
End Function

Function ExtractTableFromCSV(filepath As String, _
                             destination As Range, _
                             name As String, _
                             Optional sep As String = ",") _
As ListObject
    ' Extrait les données d'un CSV et les mets en tableau
    Dim t As ListObject
   
    Dim Data As Variant
    Data = ExtractArrayFromCSV(filepath)
    Dim ncolumns As Long: ncolumns = UBound(Data)
    Dim nrows As Long: nrows = UBound(Data, 2)
    Dim i As Long, j As Long
    With destination.Worksheet
        Set t = .ListObjects.Add(SourceType:=xlSrcRange, _
                                Source:=.Range(destination, destination.Offset(nrows, ncolumns)), _
                                XlListObjectHasHeaders:=xlYes)
         t.name = name
        Call t.Resize(.Range(destination, destination.Offset(nrows, ncolumns)))
    End With
 
    For j = 0 To ncolumns
        t.HeaderRowRange.Cells(1, j + 1) = Data(j, 0)
    Next j
    For i = 1 To nrows
        For j = 0 To ncolumns
            t.DataBodyRange.Cells(i, j + 1) = Data(j, i)
        Next j
    Next i
    
    Set ExtractTableFromCSV = t
End Function

Function ExtractArrayFromCSV(filepath As String, _
                             Optional sep As String = ",") _
As Variant
    'need to reference Microsoft Scripting Runtime.
    Dim t() As Variant
    Dim line As Variant
    Dim ncolumns As Long
    Dim i As Long: i = 0
    Dim j As Long
    Dim file As Scripting.FileSystemObject: Set file = New Scripting.FileSystemObject
    Dim content As TextStream: Set content = file.OpenTextFile(filepath, ForReading, False)
    
    While Not content.AtEndOfStream
        line = Split(content.ReadLine, sep)
        If i = 0 Then ncolumns = ArrayLen(line)
        ReDim Preserve t(0 To ncolumns - 1, 0 To i)
        For j = 0 To ncolumns - 1
            t(j, i) = line(j)
        Next j
        Increment i
    Wend
    content.Close
    ExtractArrayFromCSV = t
End Function

