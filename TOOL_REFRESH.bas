Attribute VB_Name = "TOOL_REFRESH"
Option Explicit
Option Base 0

Function refresh(activate As Boolean)
    'Active le rafraîchissement automatique ou le désactive
    Application.Calculation = IIf(activate, xlCalculationAutomatic, xlCalculationManual)
    Application.ScreenUpdating = activate
    Application.EnableEvents = activate
End Function
