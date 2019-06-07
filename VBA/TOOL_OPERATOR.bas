Attribute VB_Name = "TOOL_OPERATOR"
'Version 1 (2019-04-30)
'Contiens les fonctions
'   -> Min / Max(ParamArray)
'   -> ArrayLen(Variant 1D)
'   -> IsString(Variant)
'   -> Swap(Variant, Variant)
'   -> Increment(Variant)
'   -> Decrement(Variant)

Option Explicit
Option Base 0

Public Function Min(ParamArray values() As Variant) _
As Variant
   ' Renvoit le minimum de plusieurs valeurs Min(1, 2, 3) = 1
   Dim minValue, Value As Variant
   minValue = values(LBound(values))
   For Each Value In values
       If Value < minValue Then minValue = Value
   Next
   Min = minValue
End Function

Public Function Max(ParamArray values() As Variant) _
As Variant
  ' Renvoit le maximum de plusieurs valeurs Max(1, 2, 3) = 3
   Dim maxValue, Value As Variant
   maxValue = values(LBound(values))
   For Each Value In values
       If Value > maxValue Then maxValue = Value
   Next
   Max = maxValue
End Function

Public Function ArrayLen(Arr As Variant) _
As Integer
    'Renvoit la longueur d'un array de n'importe quel type
    ArrayLen = UBound(Arr) - LBound(Arr) + 1
End Function

Public Function IsString(str As Variant) As Boolean
    IsString = TypeName(str) = "String"
End Function

Public Function Swap(ByRef a As Variant, _
                     ByRef b As Variant)
    Dim tmp As Variant: tmp = a
    a = b
    b = tmp
End Function


Public Function Increment(ByRef X As Variant, _
                          Optional step = 1) ' ++
    ' Incremente la valeur de x
    X = X + step
End Function


Public Function Decrement(ByRef X As Variant, _
                          Optional step = 1)
    ' Decremente la valeur de x
    X = X - step
End Function

Public Function ToInt(b As Boolean) As Long
    ToInt = IIf(b, 1, 0)
End Function
