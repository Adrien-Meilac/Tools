Attribute VB_Name = "TOOL_SHOW_BOUNDARIES"
Option Explicit
Option Base 0

Function show_boundaries(rng As Range)
    ' Affiche les bordures d'un Range
    With Range(rng)
        TopLeft = Cells(.Row, .Column).Address
        TopRight = Cells(.Row, .Column + .Columns.Count).Address
        BottomLeft = Cells(.Row + .Rows.Count, .Column).Address
        BottomRight = Cells(.Row + .Rows.Count, .Column + .Columns.Count).Address
    End With
    MsgBox (TopLeft)
    MsgBox (TopRight)
    MsgBox (BottomLeft)
    MsgBox (BottomRight)
    
End Function
