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
    ' Execute une instruction pass�e sous forme d'array apr�s l'avoir concat�n�e en string
    ' show = TRUE affiche en grand ecran la fen�tre console en focus
    ' show = FALSE la cache
    ' http://www.informit.com/articles/article.aspx?p=1187429&seqNum=5
    Dim cmd_line As String ' Ligne de commande � executer
    
    cmd_line = IIf(show, "%comspec% /k ", "") & Execute_ConcatenateArgs(args) ' comspec permet de mettre en pause
    Dim windowStyle As Integer
    windowStyle = IIf(show, 3, 4) ' 3 = Affiche en grand la fen�tre, 4 = Cache la fen�tre
    
    Dim shell As Object: Set shell = VBA.CreateObject("WScript.Shell") ' Cr�ation de la fen�tre
    
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
    ' Le cas o� il y a des doubles quotes � l'int�rieur d'un des arguments n'est pas trait�
    Dim i As Long
    Dim start_index As Long: start_index = LBound(args)
    Dim stop_index As Long: stop_index = UBound(args)
    Dim cmd_line As String: cmd_line = CStr(args(start_index))

    For i = start_index + 1 To stop_index
        cmd_line = cmd_line & Chr(32)
        If InStr(args(i), " ") >= 0 Then 'Cas sp�cial des arguments avec des espaces internes
            cmd_line = cmd_line & Chr(34) & CStr(args(i)) & Chr(34)
        Else
            cmd_line = cmd_line & CStr(args(i))
        End If
    Next i
    Execute_ConcatenateArgs = cmd_line
End Function
