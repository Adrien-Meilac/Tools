Attribute VB_Name = "TOOL_EXECUTE_CMD"
Option Explicit
Option Base 0

Function execute(args() As String, _
                 Optional show As Boolean = True) _
As Boolean
    ' Execute une instruction passée sous forme d'array après l'avoir concaténée en string
    ' show = TRUE affiche en grand ecran la fenêtre console en focus
    ' show = FALSE la cache
    ' http://www.informit.com/articles/article.aspx?p=1187429&seqNum=5

    Dim shell As Object: Set shell = VBA.CreateObject("WScript.Shell") ' Création de la fenêtre
    Dim waitOnReturn As Boolean: waitOnReturn = True ' Attente du résultat pour continuer
    Dim windowStyle As Integer ' Type de la fenêtre (taille, focus, visible / caché...)
    Dim cmd_line As String: cmd_line = concatenate_args(args) ' Ligne de commande à executer
    
    If show Then
        windowStyle = 3 ' Affiche en grand la fenêtre
        cmd_line = "%comspec% /k " & cmd_line ' comspec permet de mettre en pause
    Else
        windowStyle = 4 ' Cache la fenêtre
    End If
    execute = shell.Run(cmd_line, windowStyle, waitOnReturn) ' renvoit 1 si erreur 0 sinon
End Function

Function concatenate_args(args() As String) _
As String
    ' Equivalent de la fonction <string>.join(<list>) en python
    ' Le cas où il y a des doubles quotes à l'intérieur d'un des arguments n'est pas traité
    Dim i As Long
    Dim start_index As Long: start_index = LBound(args, 1)
    Dim stop_index As Long: stop_index = UBound(args, 1)
    Dim cmd_line As String: cmd_line = args(start_index)

    For i = start_index + 1 To stop_index
        cmd_line = cmd_line & Chr(32)
        If InStr(args(i), " ") >= 0 Then 'Cas spécial des arguments avec des espaces internes
            cmd_line = cmd_line & Chr(34) & args(i) & Chr(34)
        Else
            cmd_line = cmd_line & args(i)
        End If
    Next i
    concatenate_args = cmd_line
End Function
