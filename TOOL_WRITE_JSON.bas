Attribute VB_Name = "TOOL_WRITE_JSON"
Option Explicit
Option Base 0

Function write_json(filepath As String, fields() As String, values() As String)
    'Ecrit un JSON a partir d'un vecteur de champs et de valeurs
    Dim i_min As Long: i_min = LBound(fields, 1)
    Dim i_max As Long: i_max = UBound(fields, 1)
    
    Dim content As String: content = "{" & vbNewLine
    Dim i As Long: i = i_min
    For i = i_min To i_max
        content = content & Chr(34) & fields(i) & Chr(34) & ": "
        
        If Left(values(i), 1) = "[" Then
            content = content & values(i)
        Else
            content = content & Chr(34) & values(i) & Chr(34)
        End If
        
        If i < i_max Then
            content = content & "," & vbNewLine
        Else
            content = content & vbNewLine
        End If
    Next i
    content = content & "}"
    
    Dim file As Object
    Set file = CreateObject("ADODB.Stream")
    file.Type = 2 ' specify stream type - we want To save text/string data.
    file.Charset = "utf-8" ' specify charset For the source text data.
    file.Open ' open the stream And write binary data To the object
    file.WriteText (content) ' writting the computation date and the corporate list
    Call file.SaveToFile(filepath, 2) ' saving the file in a binary format
    Set file = Nothing ' removing the object from the memory
End Function

