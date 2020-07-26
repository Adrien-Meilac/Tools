Attribute VB_Name = "TOOL_STRING_DISTANCE"
'Version 1.1 (2020-26-28)
'Contiens les fonctions
'   -> String_Distance_Levenshtein(String1, String2)

Option Explicit
Option Base 0

Function String_Distance_Levenshtein(ByVal string1 As String, ByVal string2 As String) _
As Long
    ' Compute the levenstein distance between two strings
    ' From : https://stackoverflow.com/questions/4243036/levenshtein-distance-in-vba
    Dim i As Long, j As Long, bs1() As Byte, bs2() As Byte
    Dim string1_length As Long
    Dim string2_length As Long
    Dim distance() As Long
    Dim min1 As Long, min2 As Long, min3 As Long
  
    string1_length = Len(string1)
    string2_length = Len(string2)
    ReDim distance(string1_length, string2_length)
    bs1 = string1
    bs2 = string2
  
    For i = 0 To string1_length
        distance(i, 0) = i
    Next
  
    For j = 0 To string2_length
        distance(0, j) = j
    Next
  
    For i = 1 To string1_length
        For j = 1 To string2_length
            If bs1((i - 1) * 2) = bs2((j - 1) * 2) Then
                distance(i, j) = distance(i - 1, j - 1)
            Else
                min1 = distance(i - 1, j) + 1
                min2 = distance(i, j - 1) + 1
                min3 = distance(i - 1, j - 1) + 1
                If min1 <= min2 And min1 <= min3 Then
                    distance(i, j) = min1
                ElseIf min2 <= min1 And min2 <= min3 Then
                    distance(i, j) = min2
                Else
                    distance(i, j) = min3
                End If
  
            End If
        Next
    Next
  
    String_Distance_Levenshtein = distance(string1_length, string2_length)
End Function

