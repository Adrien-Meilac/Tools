Attribute VB_Name = "TOOL_OS_CMD"
'Version 1 (2019-04-30)
'Contiens les fonctions
'   -> Execute

Option Explicit
Option Base 0

Public Function Execute(args() As Variant, _
                        Optional show As Boolean = True, _
                        Optional waitOnReturn As Boolean = True, _
                        Optional currentPath As String = "") _
As Boolean
    ' Execute une instruction passée sous forme d'array après l'avoir concaténée en string
    ' show = TRUE affiche en grand ecran la fenêtre console en focus
    ' show = FALSE la cache
    ' http://www.informit.com/articles/article.aspx?p=1187429&seqNum=5
    Dim cmd_line As String ' Ligne de commande à executer
    
    cmd_line = IIf(show, "%comspec% /k ", "") & Execute_ConcatenateArgs(args) ' comspec permet de mettre en pause
    Dim windowStyle As Integer
    windowStyle = IIf(show, 3, 4) ' 3 = Affiche en grand la fenêtre, 4 = Cache la fenêtre
    
    Dim shell As Object: Set shell = VBA.CreateObject("WScript.Shell") ' Création de la fenêtre
    
    With shell
        If Len(currentPath) > 0 Then
            .CurrentDirectory = currentPath
        End If
        Execute = .Run(cmd_line, windowStyle, waitOnReturn) ' renvoit 1 si erreur 0 sinon
    End With
End Function


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Private Function Execute_ConcatenateArgs(args() As Variant) _
As String
    ' Equivalent de la fonction <string>.join(<list>) en python
    ' Le cas où il y a des doubles quotes à l'intérieur d'un des arguments n'est pas traité
    Dim i As Long
    Dim start_index As Long: start_index = LBound(args)
    Dim stop_index As Long: stop_index = UBound(args)
    Dim cmd_line As String: cmd_line = CStr(args(start_index))

    For i = start_index + 1 To stop_index
        cmd_line = cmd_line & Chr(32)
        If InStr(args(i), " ") >= 0 Then 'Cas spécial des arguments avec des espaces internes
            cmd_line = cmd_line & Chr(34) & CStr(args(i)) & Chr(34)
        Else
            cmd_line = cmd_line & CStr(args(i))
        End If
    Next i
    Execute_ConcatenateArgs = cmd_line
End Function
