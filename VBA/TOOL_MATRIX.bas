Attribute VB_Name = "TOOL_MATRIX"
' Version 1 (2019-06-07)
' Contiens les fonctions :
'   -> Operator_lambda
'   -> Operator_mult
'   -> Operator_add

Option Explicit
Option Base 0

Function Operator_lambda(a As Double, b() As Double) As Double()
    Dim i_min As Long: i_min = LBound(b)
    Dim i_max As Long: i_max = UBound(b)
    Dim j_min As Long: j_min = LBound(b, 2)
    Dim j_max As Long: j_max = UBound(b, 2)

    Dim C() As Double
    ReDim C(i_min To i_max, j_min To j_max)
    Dim i As Long, j As Long, k As Long
    For i = i_min To i_max
        For j = j_min To j_max
            C(i, j) = a * b(i, j)
        Next
    Next
    Operator_lambda = C
End Function

Function Operator_mult(a() As Double, b() As Double) As Double()
    Dim i_min As Long: i_min = LBound(a)
    Dim i_max As Long: i_max = UBound(a)
    Dim j_min As Long: j_min = UBound(b, 2)
    Dim j_max As Long: j_max = UBound(b, 2)
    Dim k_min As Long: k_min = LBound(b)
    Dim k_max As Long: k_max = UBound(b)
    Debug.Assert k_min = LBound(a, 2)
    Debug.Assert k_max = UBound(a, 2)
    Dim C() As Double
    ReDim C(i_min To i_max, j_min To j_max)
    Dim i As Long, j As Long, k As Long
    For i = i_min To i_max
        For j = j_min To j_max
            C(i, j) = 0
            For k = k_min To k_max
                C(i, j) = C(i, j) + a(i, k) * b(k, j)
            Next
        Next
    Next
    Operator_mult = C
End Function

Function Operator_add(a() As Double, b() As Double) As Double()
    Dim i_min As Long: i_min = LBound(a)
    Dim i_max As Long: i_max = UBound(a)
    Dim j_min As Long: j_min = LBound(a, 2)
    Dim j_max As Long: j_max = UBound(a, 2)
    Debug.Assert i_min = LBound(b)
    Debug.Assert i_max = UBound(b)
    Debug.Assert j_min = LBound(b, 2)
    Debug.Assert j_max = UBound(b, 2)
    Dim C() As Double
    ReDim C(i_min To i_max, j_min To j_max)
    Dim i As Long, j As Long
    For i = i_min To i_max
        For j = j_min To j_max
            C(i, j) = a(i, j) + b(i, j)
        Next
    Next
    Operator_add = C
End Function
