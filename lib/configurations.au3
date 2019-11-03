#include <Array.au3>
#include <String.au3>
#include <FileConstants.au3>

Func StripPadding($str, $padding=" ")
    If StringLeft($str, 1) == " " Then
        $str = StringTrimLeft($str,1)
    EndIf
    If StringRight($str,1) == " " Then
        $str = StringTrimRight($str,1)
    EndIf
    Return $str
EndFunc
Func GetConfigurationParameters($path, $delimiter="=")
    Local $dic = ObjCreate("Scripting.Dictionary")
    Local $configRaw = FileRead($path)

    If @error <> 0 Then
        Return -1
    Else
        $params = _StringExplode($configRaw, @CRLF)
        For $p In $params
            $kv = _StringExplode($p, $delimiter)
            $key = StripPadding($kv[0])
            $val = StripPadding($kv[1])
            $dic.Add($key,$val)
        Next
        Return $dic
    EndIf
EndFunc
Func GetCommandLineParameters($str, $delimiter="-")
    Local $dic = ObjCreate("Scripting.Dictionary")
    Local $params = _StringExplode($str,$delimiter)

    For $p In $params
        Local $s = _StringExplode($p," ")
        Local $key = StringLower($s[0])
        If $key <> "" Then 
            Local $val = ""
            For $i = 1 To UBound($s)-1
                If $s[$i] <> "" Then
                    If $i <> 1 Then
                        $val &= " "
                    EndIf
                    $val &= $s[$i]
                EndIf
            Next
            $dic.Add($key,$val)
        EndIf
    Next
    Return $dic
EndFunc
