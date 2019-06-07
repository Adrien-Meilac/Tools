Attribute VB_Name = "TOOL_TABLE"
'Version 1.1 (2019-05-15)
'Contiens les fonctions
'   -> TableColumnModify(ListObject, String, String)
'   -> TableCopyAndName(ListObject, Range, [name= String])
'   -> TableDeleteAllRows(ListObject)
'   -> TableAddRows(ListObject, Long)
'   -> TableAt(ListObject, i As Long, column As String)
'   -> TableRowAsDict(ListObject, Long, ncolumns As Long) As Scripting.Dictionary

Option Explicit
Option Base 0

Public Function TableColumnModify(t As ListObject, _
                                  column As String, _
                                  format As String)
    ' Modifie le format d'une colonne d'un tableau
    If format = "euro" Then
        format = "_-* #,##0.00 [$€-40C]_-;-* #,##0.00 [$€-40C]_-;_-* ""-""?? [$€-40C]_-;_-@_-"
    ElseIf format = "percentage" Then
        format = "0.00%"
    End If
    t.ListColumns(column).DataBodyRange.NumberFormat = format
End Function

Function TableCopyAndName(ByRef t As ListObject, _
                          destination As Range, _
                          Optional name As String = "") _
As ListObject
    ' Crée une copie d'un tableau et lui donne un nouveau nom
    Call t.Range.Copy
    Call destination.PasteSpecial(xlPasteValues)
    Dim nrows As Long: nrows = t.Range.Rows.Count
    Dim ncolumns As Long: ncolumns = t.Range.Columns.Count
    Dim t2 As ListObject
    Set t2 = destination.Worksheet.ListObjects.Add(SourceType:=xlSrcRange, _
                                                  Source:=destination.Worksheet.Range(destination, destination.Offset(nrows - 1, ncolumns - 1)), _
                                                  XlListObjectHasHeaders:=xlYes)
    If Len(name) > 0 Then
        t2.name = name
    End If
    Set TableCopyAndName = t2
End Function

Public Function TableDeleteAllRows(ByRef t As ListObject)
    ' Supprime toutes les lignes présentes dans un tableau
    On Error Resume Next
    With t.DataBodyRange
        .Rows(1).ClearContents '~~> Clear Header Row `IF` it exists
        .Offset(1, 0).Resize(.Rows.Count - 1, .Columns.Count).Rows.Delete '~~> Delete all the other rows `IF `they exist
    End With
    On Error GoTo 0
End Function

Public Function TableAddRows(ByRef t As ListObject, _
                             Optional N As Long)
    ' Ajoute N lignes vides au tableau
    Refresh (False)
    Dim i As Long
    For i = 1 To N
        t.ListRows.Add (t.ListRows.Count + 1)
    Next
    Refresh (True)
End Function

Public Function TableAt(t As ListObject, _
                 i As Long, _
                 column As String) _
As Variant
    TableAt = t.ListColumns(column).DataBodyRange.Cells(i, 1)
End Function

Public Function TableRowAsDict(t As ListObject, _
                               i As Long, _
                               ncolumns As Long) _
As Scripting.Dictionary
    Dim d As New Scripting.Dictionary
    Dim j As Long
    For j = 1 To ncolumns
        d(t.HeaderRowRange(j).Value) = t.DataBodyRange.Cells(i, j)
    Next
    Set ExtractTableRowAsDict = d
End Function

