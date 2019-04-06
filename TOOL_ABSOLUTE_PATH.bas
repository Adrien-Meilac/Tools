Attribute VB_Name = "TOOL_ABSOLUTE_PATH"
Option Explicit
Option Base 0

Private global_root As String

Public Function AbsolutePath(path As String, _
                             Optional root As String = "") _
As String
    ' Converti un chemin relatif ou absolu en chemin absolu
    If Len(root) = 0 Then
        root = global_root ' utilisation de la variable globale
    Else
        global_root = root ' initialisation de la variable globale
    End If
    
    Dim absolute_path As String: absolute_path = root & "\" & path
    
    If Len(Dir(absolute_path, vbDirectory)) > 0 Then
         convertToAbsolutePath = absolute_path
    Else
         convertToAbsolutePath = path
    End If
End Function

