#include <Array.au3>
#include <String.au3>

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
