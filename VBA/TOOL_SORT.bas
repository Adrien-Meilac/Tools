Attribute VB_Name = "TOOL_SORT"
'Version 1 (2019-04-30)
'Contiens les fonctions
'   ->QuickSortArray(1D array Variant)
'   ->QuickSortTable(2D array variant, array sortcolumns)

Option Explicit
Option Base 0


Public Function QuickSortArray(ByRef L As Variant)
    Call QuickSortArrayPart(L, LBound(L), UBound(L))
    QuickSortArray = L
End Function
                          

Public Function QuickSortTable(ByRef t() As Variant, _
                               sortColumns As Variant)
    Call QuickSortTablePart(t, LBound(t), UBound(t), LBound(t, 2), UBound(t, 2), sortColumns)
    QuickSortTable = t
End Function

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Function QuickSortArrayPart(ByRef L As Variant, _
                                    i_min As Long, _
                                    i_max As Long)
    ' Tri en place pour les vecteurs unidimensionnels
    ' Complexité : O(n ln(n))
    Dim pivot   As Variant: pivot = L((i_min + i_max) \ 2)
    Dim temp_i_min  As Long: temp_i_min = i_min
    Dim temp_i_max   As Long: temp_i_max = i_max

    Dim tmp_swap As Variant

    While (temp_i_min <= temp_i_max)
        While (L(temp_i_min) < pivot And temp_i_min < i_max)
            Increment temp_i_min
        Wend

         While (pivot < L(temp_i_max) And temp_i_max > i_min)
            Decrement temp_i_max
         Wend
    
         If (temp_i_min <= temp_i_max) Then
            Call Swap(L(temp_i_min), L(temp_i_max))
            
            Increment temp_i_min
            Decrement temp_i_max
         End If
      Wend

  If (i_min < temp_i_max) Then
    Call QuickSortArrayPart(L, i_min, temp_i_max)
  End If
  
  If (temp_i_min < i_max) Then
    Call QuickSortArrayPart(L, temp_i_min, i_max)
  End If
  
End Function

Private Function QuickSortTablePart_CompareList(L0 As Variant, _
                                                L1 As Variant)
    Dim k As Long
    Dim k_min As Long: k_min = LBound(L1)
    Dim k_max As Long: k_max = UBound(L1)
    For k = k_min To k_max
        If L0(k) < L1(k) Then
            QuickSortTablePart_CompareList = 1
            Exit Function
        ElseIf L0(k) > L1(k) Then
            QuickSortTablePart_CompareList = 0
            Exit Function
        End If
    Next
    QuickSortTablePart_CompareList = -1
End Function

Private Function QuickSortTablePart(ByRef t() As Variant, _
                                    i_min As Long, _
                                    i_max As Long, _
                                    j_min As Long, _
                                    j_max As Long, _
                                    sortColumns As Variant)
    ' Tri en place pour les tableaux multidimensionnels
    ' Complexité : O(n ln(n))
    Dim k As Long, j As Long
    Dim k_min As Long: k_min = LBound(sortColumns)
    Dim k_max As Long: k_max = UBound(sortColumns)
    Dim pivot() As Variant: ReDim pivot(k_min To k_max)
    
    For k = k_min To k_max
        pivot(k) = t((i_min + i_max) \ 2, sortColumns(k))
    Next

    Dim temp_i_min  As Long: temp_i_min = i_min
    Dim temp_i_max   As Long: temp_i_max = i_max

    Dim L1() As Variant, L2() As Variant
    ReDim L1(k_min To k_max)
    ReDim L2(k_min To k_max)
    
    While (temp_i_min <= temp_i_max)
        Do While (temp_i_min < i_max)
            For k = k_min To k_max
                L1(k) = t(temp_i_min, sortColumns(k))
                L2(k) = pivot(k)
            Next
            If QuickSortTablePart_CompareList(L1, L2) = 1 Then
                Increment temp_i_min
            Else
                Exit Do
            End If
        Loop

        Do While (temp_i_max > i_min)
            For k = k_min To k_max
                L1(k) = t(temp_i_max, sortColumns(k))
                L2(k) = pivot(k)
            Next
            If QuickSortTablePart_CompareList(L1, L2) = 0 Then
                Decrement temp_i_max
            Else
                Exit Do
            End If
        Loop
        
        If (temp_i_min <= temp_i_max) Then
           For j = j_min To j_max
               Call Swap(t(temp_i_min, j), t(temp_i_max, j))
           Next
           Increment temp_i_min
           Decrement temp_i_max
        End If
      Wend
  If (i_min < temp_i_max) Then
    Call QuickSortTablePart(t, i_min, temp_i_max, j_min, j_max, sortColumns)
  End If
  
  If (temp_i_min < i_max) Then
    Call QuickSortTablePart(t, temp_i_min, i_max, j_min, j_max, sortColumns)
  End If
  
End Function

