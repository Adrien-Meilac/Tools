Attribute VB_Name = "TOOL_READ"
'Version 1 (2019-04-30)
'Contiens les fonctions :
'   -> ReadArray(rng As Range) As Variant()
'   -> ReadArrayDouble(rng As Range) As Double()

Option Explicit
Option Base 0

Public Function ReadArray(rng As Range) As Variant()
    Dim X() As Variant
    Dim cell_value As Variant
    ReDim X(rng.Count - 1)
    Dim i As Long: i = 0
    For Each cell_value In rng.Value
        X(i) = cell_value
        Increment i
    Next
    ReadArray = X
End Function

Public Function ReadArrayDouble(rng As Range) As Double()
    Dim X() As Double
    Dim cell_value As Variant
    ReDim X(rng.Count - 1)
    Dim i As Long: i = 0
    For Each cell_value In rng.Value
        X(i) = cell_value
        Increment i
    Next
    ReadArrayDouble = X
End Function
