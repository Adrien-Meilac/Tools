Attribute VB_Name = "TOOL_EXECUTE_CMD"
Option Explicit
Option Base 0

Function execute(args() As String, _
                 Optional show As Boolean = True) _
As Boolean
    ' Execute une instruction pass�e sous forme d'array apr�s l'avoir concat�n�e en string
    ' show = TRUE affiche en grand ecran la fen�tre console en focus
    ' show = FALSE la cache
    ' http://www.informit.com/articles/article.aspx?p=1187429&seqNum=5

    Dim shell As Object: Set shell = VBA.CreateObject("WScript.Shell") ' Cr�ation de la fen�tre
    Dim waitOnReturn As Boolean: waitOnReturn = True ' Attente du r�sultat pour continuer
    Dim windowStyle As Integer ' Type de la fen�tre (taille, focus, visible / cach�...)
    Dim cmd_line As String: cmd_line = concatenate_args(args) ' Ligne de commande � executer
    
    If show Then
        windowStyle = 3 ' Affiche en grand la fen�tre
        cmd_line = "%comspec% /k " & cmd_line ' comspec permet de mettre en pause
    Else
        windowStyle = 4 ' Cache la fen�tre
    End If
    execute = shell.Run(cmd_line, windowStyle, waitOnReturn) ' renvoit 1 si erreur 0 sinon
End Function

Function concatenate_args(args() As String) _
As String
    ' Equivalent de la fonction <string>.join(<list>) en python
    ' Le cas o� il y a des doubles quotes � l'int�rieur d'un des arguments n'est pas trait�
    Dim i As Long
    Dim start_index As Long: start_index = LBound(args, 1)
    Dim stop_index As Long: stop_index = UBound(args, 1)
    Dim cmd_line As String: cmd_line = args(start_index)

    For i = start_index + 1 To stop_index
        cmd_line = cmd_line & Chr(32)
        If InStr(args(i), " ") >= 0 Then 'Cas sp�cial des arguments avec des espaces internes
            cmd_line = cmd_line & Chr(34) & args(i) & Chr(34)
        Else
            cmd_line = cmd_line & args(i)
        End If
    Next i
    concatenate_args = cmd_line
End Function
