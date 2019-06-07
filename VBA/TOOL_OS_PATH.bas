Attribute VB_Name = "TOOL_OS_PATH"
'Version 1 (2019-04-30)
'Contiens les fonctions
'   -> AbsolutePath(String, [root=String])
'   -> MkDirReccursive(String)
'   -> GetDirectory(String) : Dossier du fichier
'   -> DeleteFile(String)
'   -> FileExists(String)

Option Explicit
Option Base 0

Private global_root As String 'Pour la fonction absolute path

Public Function AbsolutePath(path As String, _
                             Optional root As String) _
As String
    ' Converti un chemin relatif ou absolu en chemin absolu
    ' Une fois la racine fix�e, il n'est plus n�cessaire de la pr�ciser
    If IsMissing(root) Then
        root = global_root ' utilisation de la variable globale
    Else
        global_root = root ' initialisation de la variable globale
    End If
    
    Dim absolute_path As String
    Dim isDir As Boolean
    
    absolute_path = root & "\" & path
    isDir = Len(Dir(absolute_path, vbDirectory)) > 0
    AbsolutePath = IIf(isDir, absolute_path, path)
End Function

Public Function MkDirReccursive(path As String) _
As Boolean
    ' Cr�e plusieurs dossier imbriqu� d'un coup, MkDir est capable de cr�er
    ' les dossiers que 1 par 1
    ' Renvoit un bool�en, vrai si le dossier est bien cr�� ou d�j� cr��
    ' Evite les probl�mes des chemins commen�ant par \\
    If Len(Dir(path, vbDirectory)) > 0 Then
        Debug.Print ("Le chemin existe d�j�")
        MkDirReccursive = True
        Exit Function
    End If
    
    '' D�tection du chemin primitif existant
    Dim folder() As String ' Liste des fichiers � cr�er
    Dim root_path As String: root_path = path
    Dim last_folder As String
    
    While Len(Dir(root_path, vbDirectory)) = 0 ' Tant que le chemin n'existe pas
        last_folder = InStrRev(root_path, "\")
        If last_folder <> -1 Then ' On retire un fichier
            root_path = Left$(root_path, last_folder - 1)
        Else
            Debug.Print ("Erreur : Le chemin ne peut pas �tre cr��")
            MkDirReccursive = False
            Exit Function
        End If
    Wend
    
    folder = Split(Right$(path, Len(path) - Len(root_path) - 1), "\")
    Dim i_min As Long: i_min = LBound(folder)
    Dim i_max As Long: i_max = UBound(folder)
    Dim i As Long
    
    For i = i_min To i_max
        If Len(folder(i)) > 0 Then
            root_path = root_path & "\" & folder(i)
            MkDir (root_path)
        End If
    Next i
    MkDirReccursive = Len(Dir(path, vbDirectory)) > 0
End Function

Public Function GetFolder(path As String) _
As String
   GetDirectory = Left$(path, InStrRev(path, "\") - 1)
End Function

Public Function GetExtension(path As String) _
As String
   GetDirectory = Mid$(path, InStrRev(path, ".") - 1)
End Function

Public Function FileExists(ByVal FileToTest As String) As Boolean
   FileExists = (Dir(FileToTest) <> "")
End Function

Public Function DeleteFile(ByVal FileToDelete As String)
   If FileExists(FileToDelete) Then 'See above
      ' First remove readonly attribute, if set
      Call SetAttr(FileToDelete, vbNormal)
      ' Then delete the file
      Call Kill(FileToDelete)
   End If
End Function


