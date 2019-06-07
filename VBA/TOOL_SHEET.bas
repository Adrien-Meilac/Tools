Attribute VB_Name = "TOOL_SHEET"
'Version 1 (2019-04-30)
'Contiens les fonctions
'   -> Refresh(Boolean)
'   -> UpdateSheet(String)

Option Explicit
Option Base 0

Public Function Refresh(activate As Boolean)
    'Active le rafra�chissement automatique ou le d�sactive
    Application.Calculation = IIf(activate, xlCalculationAutomatic, xlCalculationManual)
    Application.ScreenUpdating = activate
    Application.EnableEvents = activate
End Function

Public Function UpdateSheet(sheetname As String)
    ' Pour assigner la macro � un bouton : 'UpdateSheet("INPUT")'
    ' Attention les simple quote '' sont n�cessaires
    Worksheets(sheetname).activate
End Function

