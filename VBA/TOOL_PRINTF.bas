Attribute VB_Name = "TOOL_PRINTF"
Option Explicit
Option Base 0

Public Function printf(mask As String, ParamArray tokens()) As String
    ' Fonction qui formate les chaînes de caractère
    ' synthaxe : printf("essai {0}, valeur = {1}", valeur0, valeur1) peut importe le type des éléments
    Dim i As Long
    Dim i_min As Long: i_min = LBound(tokens)
    Dim i_max As Long: i_max = UBound(tokens)
    For i = i_min To i_max
        mask = Replace$(mask, "{" & i & "}", tokens(i))
    Next
    printf = mask
End Function
