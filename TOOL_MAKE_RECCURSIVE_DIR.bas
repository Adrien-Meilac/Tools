Attribute VB_Name = "TOOL_MAKE_RECCURSIVE_DIR"
Option Explicit
Option Base 0

Public Function MkDirReccursive(path As String) As Boolean
    ' Cr�e plusieurs dossier imbriqu� d'un coup, MkDir est capable de cr�er les dossiers que 1 par 1
    ' Renvoit un bool�en, vrai si le dossier est bien cr�� ou d�j� cr��
    ' Evite les probl�mes des chemins commen�ant par \\
    If Len(Dir(path, vbDirectory)) > 0 Then
        Debug.Print ("Le chemin existe d�j�")
        MkDirReccursive = True
        Exit Function
    End If
    
    Dim root_path As String: root_path = path
    While Len(Dir(root_path, vbDirectory)) = 0 ' Chemin primitif existant
        If InStrRev(root_path, "\") <> -1 Then
            root_path = Left(root_path, InStrRev(root_path, "\") - 1)
        Else
            Debug.Print ("Erreur : Le chemin ne peut pas �tre cr��")
            MkDirReccursive = False
            Exit Function
        End If
    Wend
    
    Dim folder() As String: folder = Split(Right(path, Len(path) - Len(root_path) - 1), "\")
    Dim i As Long
    
    For i = LBound(folder, 1) To UBound(folder, 1)
        If Len(folder(i)) > 0 Then
            root_path = root_path & "\" & folder(i)
            MkDir (root_path)
        End If
    Next i
    MkDirReccursive = Len(Dir(path, vbDirectory)) > 0
End Function

Function MkDirReccursiveArray(paths() As String)
    ' Cr�e une liste de chemin
    Dim i As Long
    Dim i_min As Long: i_min = LBound(paths, 1)
    Dim i_max As Long: i_max = UBound(paths, 1)
    For i = i_min To i_max
        MkDirReccursive (path)
    Next i
End Function

