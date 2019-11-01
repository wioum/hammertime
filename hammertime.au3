#include <Misc.au3>
#include "lib/commandline.au3"

Opt("TrayAutoPause", 0)
Opt("WinTitleMatchMode", 2)

$dll = DllOpen("user32.dll")

$title = ""
$t1 = 100
$t2 = 200

$dicButton = ObjCreate("Scripting.Dictionary")
$dicButton.Add("30","0")
$dicButton.Add("31","1")
$dicButton.Add("32","2")
$dicButton.Add("33","3")
$dicButton.Add("34","4")
$dicButton.Add("35","5")
$dicButton.Add("36","6")
$dicButton.Add("37","7")
$dicButton.Add("38","8")
$dicButton.Add("39","9")

$dicMod = ObjCreate("Scripting.Dictionary")
$dicMod.Add("10","+") ; shift
$dicMod.Add("11","^") ; ctrl
$dicMod.Add("12","!") ; alt

$params = GetCommandLineParameters($CmdLineRaw,"/")

For $param In $params
	Switch ($param)
		Case "title"
			MsgBox(0,'Param',$param & ' = ' & $params.Item($param))
			$title = $params.Item($param)
		Case Else
	EndSwitch
Next

TraySetToolTip("Hammer Time")
If $title <> "" Then
	TrayItemSetState(TrayCreateItem("Hammer Time"),128)
	TrayItemSetState(TrayCreateItem("@ " & $title),128)
EndIf

$cmd = ""

While 1
	If WinActive($title) Then
		For $b In $dicButton 
			If _IsPressed($b, $dll) Then
				$cmd = ""
				For $m In $dicMod 
					If _IsPressed($m, $dll) Then
						$cmd &= $dicMod.Item($m)
					EndIf
				Next
				$cmd &= "{" & $dicButton.Item($b) & "}"
				Send($cmd)
			EndIf
		Next
	EndIf
	Sleep(Random($t1,$t2,1))
WEnd

DllClose($dll)