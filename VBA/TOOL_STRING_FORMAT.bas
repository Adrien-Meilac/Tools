Attribute VB_Name = "TOOL_STRING_FORMAT"
'Version 1 (2019-04-30)
'Contiens les fonctions
'   -> Printf
'   -> SplitEx

Option Explicit
Option Base 0

Public Function Printf(mask As String, ParamArray tokens()) _
As String
    ' Fonction qui formate les chaînes de caractère
    ' synthaxe : printf("essai {0}, valeur = {1}", valeur0, valeur1) peut importe le type des éléments
    Dim i As Long
    Dim i_min As Long: i_min = LBound(tokens)
    Dim i_max As Long: i_max = UBound(tokens)
    If InStr(mask, "{}") < 0 Then
        For i = i_min To i_max
            mask = replace$(mask, "{" & i & "}", CStr(tokens(i)))
        Next
    Else
        For i = i_min To i_max
            mask = replace$(mask, "{}", CStr(tokens(i)), Count:=1)
        Next
    End If
    Printf = mask
End Function

Public Function SplitEx(InString As String, _
                    Delimiter As String, _
                    Optional GroupChar As String = vbNullString, _
                    Optional IgnoreConsecutiveDelimiters As Boolean = False, _
                    Optional Escape As String = vbNullString, _
                    Optional RemoveEscape As Boolean = True, _
                    Optional DeleteGroupCharacters As Boolean = False) _
As String()
    '====================================================================================
    ' SplitEx
    ' By Chip Pearson, chip@cpearson.com , www.cpearson.com, www.cpearson.com/Excel/Split.aspx
    '
    ' SplitEx is an extension to the standard VBA Split method. If all the optional
    ' parameters are omitted, SplitEx works just like Split.
    '
    ' SplitEx provides the following advantages of the standard Split method:
    '
    '   GroupChar: This specifies a character that is used to delimit a range
    '   in the input string within which any delimiter characters are to be ignored.
    '   Most commonly, this is used to prevent SplitEx from splitting on a space
    '   character that occurs within a quoted string. For example,
    '       InputString = Hello "big world" from VB
    '   If you set the GroupChar to Chr(34), the space within the quoted string
    '   will not cause a split. The second element will be "big world" (with the quotes).
    '
    '   IgnoreConsecutiveDelimiters: This tells SplitEx to ignore consecutive delimiters
    '   and treat them as a single delimiter. For example,
    '       InputString = Hello|World||From VBA
    '   SplitEx treats the consecutive delimiters || after 'World' as a single
    '   delimter, so the string is split as if it were Hello|World|From VBA
    '
    '   Escape: This escapes a delimiter, so that it will not be used by Split. For
    '   example,
    '       InputString = Hello|Big\|World gets split into two components, not three.
    '   The | delimiter that follows the \ escape character is not used by the split.
    '   The second element is the text Big\|World
    '
    '   RemoveEscape: This causes the code to remove the escape character from the
    '   final Split. For example, let Escape = '\' and InString is 'Hello|Big\|World'
    '   If RemoveEscape is False, the second element is 'Big\|World'. If RemoveEscape
    '   is True, the second element is 'Big|World', with the \ character removed.
    '
    '   DeleteGroupCharacters: If True, all instances of GroupChar are removed from
    '   the output. Otherwse, the GroupChar remains.
    '
    ' Results:
    '   Normal: An array of strings that were split apart in the manner prescribed by
    '       the various options.
    '   If InString is an empty string, an uninitialized array is returned. Test this with
    '       code like:
    '           Dim SS() As String
    '           SS = SplitEx(...)
    '           If IsError(LBound(SS)) = True Then
    '               ' uninitialized array. InString was empty
    '           End If
    '   If Delimiter is an empty string, the result is an array of one element that
    '   contains InString.
    '====================================================================================
    Dim InGroup As Boolean
    Dim Arr() As String
    Dim N As Long
    Dim InGroupReplace As String
    Dim s As String
    Dim Done As Boolean
    Dim M As Long
    Dim EscapeReplace As String
    
    '
    ' In the input string is empty, return the
    ' unallocated array.
    '
    If InString = vbNullString Then
        SplitEx = Arr
        Exit Function
    End If
    
    '
    ' If the delimiter is empty, return a single
    ' element array containing the input string.
    '
    If Len(Delimiter) = 0 Then
        ReDim Arr(0 To 0)
        Arr(0) = InString
        Exit Function
    End If
    
    s = InString
    N = 1
    Done = False
    '
    ' Find a character that is not used in InString. This character
    ' will be used to replace Delimiter when Delimiter occurs with
    ' a group of characters delimited by GroupChar.
    Do Until Done
        If StrComp(Chr(N), Delimiter, vbBinaryCompare) <> 0 Then
            M = InStr(1, s, Chr(N), vbBinaryCompare)
            If M = 0 Then
                InGroupReplace = Chr(N)
                Done = True
            End If
        End If
        N = N + 1
    Loop
    InGroupReplace = Chr(N)
    N = N + 1
    Done = False
    '
    ' Find a character not used in InString that we can
    ' use to mark an escaped delimter (an escaped delimiter
    ' is a delimiter than isn't used by the Split function).
    If Escape <> vbNullString Then
        Do Until Done
            If StrComp(Chr(N), Escape, vbTextCompare) <> 0 Then
                M = InStr(1, s, Chr(N), vbBinaryCompare)
                If M = 0 Then
                    EscapeReplace = Chr(N)
                    Done = True
                End If
            End If
            N = N + 1
        Loop
    End If
        
    '
    ' Replace existing escaped delimiters with the EscapeReplace
    ' character.
    If Escape <> vbNullString Then
        s = replace(s, Escape & Delimiter, EscapeReplace)
    End If
        
    '
    ' If we are ignoring consecutive delimiters, replace
    ' consecutive delimiters with a single delimiter.
    If IgnoreConsecutiveDelimiters = True Then
        N = InStr(1, s, Delimiter & Delimiter, vbBinaryCompare)
        Do Until N = 0
            s = replace(s, Delimiter & Delimiter, Delimiter)
            N = InStr(1, s, Delimiter & Delimiter, vbBinaryCompare)
        Loop
    End If
    
    '
    ' Scan string and replace any delimter that occurs within
    ' a group sequence with InGroupReplace
    If Len(GroupChar) > 0 Then
        For N = 1 To Len(s)
            If Mid(s, N, Len(GroupChar)) = GroupChar Then
                InGroup = Not InGroup
            End If
            If Mid(s, N, 1) = Delimiter Then
                If InGroup Then
                    Mid(s, N, 1) = InGroupReplace
                End If
            End If
        Next N
    End If
    
    ' do the split
    Arr = Split(s, Delimiter)
    ' loop through the array and replace our special control
    ' characters with their original value.
    For N = LBound(Arr) To UBound(Arr)
        Arr(N) = replace(Arr(N), InGroupReplace, Delimiter)
        If DeleteGroupCharacters = True Then
            Arr(N) = replace(Arr(N), GroupChar, vbNullString)
        End If
        If EscapeReplace <> vbNullString Then
            If RemoveEscape = True Then
                Arr(N) = replace(Arr(N), EscapeReplace, Delimiter)
            Else
                Arr(N) = replace(Arr(N), EscapeReplace, Escape & Delimiter)
            End If
        End If
    Next N
    SplitEx = Arr

End Function




