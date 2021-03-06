Scriptname DM_Utils Hidden

import StringUtil
Import Math
import JValue

float Function Exp(float x) Global
    {e^x}
    return Pow(2.718282, x)
EndFunction

; Linear interpolation. Percent [0.0, 1.0]
float Function Lerp(float min, float max, float percent) Global
    Return ((max - min) * percent) + min
EndFunction

int function MaxI(int a, int b) Global
    if a > b
        Return a
    Else
        Return b
    EndIf
EndFunction

int Function MinI(int a, int b) Global
    if a < b
        Return a
    Else
        Return b
    EndIf
EndFunction

float function MaxF(float a, float b) Global
    if a > b
        Return a
    Else
        Return b
    EndIf
EndFunction

float Function MinF(float a, float b) Global
    if a < b
        Return a
    Else
        Return b
    EndIf
EndFunction

float Function EnsurePositiveF(float x) Global
    Return MaxF(x, 0)
EndFunction

float Function ConstrainF(float a, float aMin, float aMax) Global
    Return MinF(aMax, MaxF(a, aMin))
EndFunction

int Function Round(float x) Global
    int temp
    float dec
    If x > 0
        temp = Math.Floor(x)
        dec = x - temp
        if dec >= 0.5
            temp = temp + 1
        EndIf
    ElseIf x < 0
        temp = Math.Ceiling(x)
        dec = Math.abs(x - temp)
        if dec >= 0.5
            temp = temp - 1
        EndIf
    Else
        temp = 0
    EndIf

    Return temp
EndFunction

string Function FloatToStr(float x, int decimals = 2) Global
    If decimals < 1
        ; Delete the decimal point
        decimals = -1
    EndIf

    return Substring( x as string, 0, Find(x as string, ".", 0) + 1 + decimals )
EndFunction

; Decimal to percent
float Function ToPercent(float x) Global
    Return x * 100
EndFunction

; Decimal to percent
float Function FloatToPercent(float x) Global
    Return x * 100
EndFunction

; Percent to decimal
float Function FromPercent(float x) Global
    return x / 100
EndFunction

float Function PercentToFloat(float x) Global
    {Better naming}
    Return FromPercent(x)
EndFunction

float Function GameHourRatio() Global
    return 1.0 / 24.0
endFunction

float Function Now() Global
    Return Utility.GetCurrentGameTime()
EndFunction


; Cambia un número de horas de juego a horas reales
float Function ToRealHours(float aVal) Global
    Return aVal / GameHourRatio()
EndFunction


; Cambia un número de horas reales a horas de juego
float Function ToGameHours(float aVal) Global
    Return aVal * GameHourRatio()
EndFunction

string Function FloatToHour(float aH) Global
    int h = Floor(aH)
    int m = Floor((aH - h) * 60)
    Return PadZeros(h, 2) + ":" + PadZeros(m, 2)
EndFunction

string Function PadZeros(int x, int n = 0) Global
    string r = x as string
    int m = n - GetLength(r)
    int i = 0
    While i < m
        r = "0" + r
        i += 1
    EndWhile
    Return r
EndFunction

int Function IndexOfS(string[] aArray, string s) Global
    {Searchs a string in an array of strings}
    int n = aArray.length
    int i = 0
    While i < n
        If aArray[i] == s
            Return i
        EndIf
        i += 1
    EndWhile
    Return -1
EndFunction

int Function IndexOfSBin(string[] aArray, string s) Global
    {Binary search on a sorted array.}
    int n = aArray.length
    int l = 0
    int r = n - 1
    int m
    While (l <= r)
        m = Floor((l + r) / 2)
        If (aArray[m] < s)
            l = m + 1
        ElseIf (aArray[m] > s)
            r = m - 1
        Else
            return m
        EndIf
    EndWhile
    return -1
EndFunction

string Function GetActorName(Actor aActor) Global
    return (aActor.GetActorBase() as Form).GetName()
EndFunction

; Prints some color in hex format.
string Function ColorToStr(int color) Global
    return evalLuaStr(0, "return dmlib.printColor(" + color + ")")
EndFunction
