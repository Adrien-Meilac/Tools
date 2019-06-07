Attribute VB_Name = "TOOL_WRITE"
'Version 1 (2019-04-30)
'Contiens les fonctions
'   -> WriteSheetTable(2D array variant, Range)
'   -> WriteSheetArray(1D array variant, Range)

Option Explicit
Option Base 0

Public Function WriteSheetTable(Table As Variant, _
                                start As Range)
    Dim i As Long, j As Long
    Dim i_min As Long: i_min = LBound(Table)
    Dim i_max As Long: i_max = UBound(Table)
    Dim j_min As Long: j_min = LBound(Table, 2)
    Dim j_max As Long: j_max = UBound(Table, 2)
    
    With start
        For i = i_min To i_max
            For j = j_min To j_max
                .Offset(i - i_min, j - j_min).Value = Table(i, j)
            Next
        Next
    End With
End Function

Public Function WriteSheetArray(Table As Variant, _
                                start As Range, _
                                Optional column As Boolean = True)
    Dim i As Long, j As Long
    Dim i_min As Long: i_min = LBound(Table)
    Dim i_max As Long: i_max = UBound(Table)
    
    With start
        If column Then ' Ecriture en colonne
            For i = i_min To i_max
                .Offset(i - i_min, 0).Value = Table(i)
            Next
        Else ' Ecriture en ligne
            For i = i_min To i_max
                .Offset(0, i - i_min).Value = Table(i)
            Next
        End If
    End With
End Function
