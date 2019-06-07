Attribute VB_Name = "TOOL_MATRIX"
' Version 1 (2019-06-07)
' Contiens les fonctions :
'   -> Operator_lambda
'   -> Operator_mult
'   -> Operator_add

Option Explicit
Option Base 0

Function Operator_lambda(A As Double, B() As Double) As Double()
    Dim i_min As Long: i_min = LBound(B)
    Dim i_max As Long: i_max = UBound(B)
    Dim j_min As Long: j_min = LBound(B, 2)
    Dim j_max As Long: j_max = UBound(B, 2)

    Dim C() As Double
    ReDim C(i_min To i_max, j_min To j_max)
    Dim i As Long, j As Long, k As Long
    For i = i_min To i_max
        For j = j_min To j_max
            C(i, j) = A * B(i, j)
        Next
    Next
    Operator_lambda = C
End Function

Function Operator_mult(A() As Double, B() As Double) As Double()
    Dim i_min As Long: i_min = LBound(A)
    Dim i_max As Long: i_max = UBound(A)
    Dim j_min As Long: j_min = UBound(B, 2)
    Dim j_max As Long: j_max = UBound(B, 2)
    Dim k_min As Long: k_min = LBound(B)
    Dim k_max As Long: k_max = UBound(B)
    Debug.Assert k_min = LBound(A, 2)
    Debug.Assert k_max = UBound(A, 2)
    Dim C() As Double
    ReDim C(i_min To i_max, j_min To j_max)
    Dim i As Long, j As Long, k As Long
    For i = i_min To i_max
        For j = j_min To j_max
            C(i, j) = 0
            For k = k_min To k_max
                C(i, j) = C(i, j) + A(i, k) * B(k, j)
            Next
        Next
    Next
    Operator_mult = C
End Function

Function Operator_add(A() As Double, B() As Double) As Double()
    Dim i_min As Long: i_min = LBound(A)
    Dim i_max As Long: i_max = UBound(A)
    Dim j_min As Long: j_min = LBound(A, 2)
    Dim j_max As Long: j_max = UBound(A, 2)
    Debug.Assert i_min = LBound(B)
    Debug.Assert i_max = UBound(B)
    Debug.Assert j_min = LBound(B, 2)
    Debug.Assert j_max = UBound(B, 2)
    Dim C() As Double
    ReDim C(i_min To i_max, j_min To j_max)
    Dim i As Long, j As Long
    For i = i_min To i_max
        For j = j_min To j_max
            C(i, j) = A(i, j) + B(i, j)
        Next
    Next
    Operator_add = C
End Function
