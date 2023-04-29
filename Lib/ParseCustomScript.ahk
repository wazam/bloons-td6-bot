; Thanks to Jonny, Rajat, Rickly, JoeSchmoe https://www.autohotkey.com/board/topic/3152-execute-ahk-code-dynamically/?p=20192

ParseCustomScript(CmdLine, Options="") {
	global p0, VariableNames
	CmdLine = %CmdLine%

	If (SemiColonLoc := InStr(CmdLine, "`;")) {
		StringLeft, CmdLine, CmdLine, % SemiColonLoc -1
	}

	IsAFunctionRE = SP)^[a-zA-Z0-9_.]+\(.*\)
	If (RegExMatch( CmdLine, IsAFunctionRE, m)) {
		StringReplace, CmdLine, CmdLine, (, `,
		StringLeft, CmdLine, CmdLine, InStr(CmdLine, ")",1 ,0)-1
		IsAFunction = 1
	}

	Loop, Parse, CmdLine, `,, %A_Space%%A_Tab%`n`r
	{
		P%A_Index% := ActiveText(A_LOOPFIELD, VariableNames)
		P0 = %A_Index%
	}

	If (IsAFunction) {
		Gosub, % "Func" (p0 - 1)
	} ; Else If IsLabel(P1) {
	; 	Gosub, %P1%
	; }
	Return

	Func0:
		ret := %p1%()
		Return
	Func1:
		ret := %p1%(p2)
		Return
	Func2:
		ret := %p1%(p2,p3)
		Return
	Func3:
		ret := %p1%(p2,p3,p4)
		Return
	Func4:
		ret := %p1%(p2,p3,p4,p5)
		Return
	Func5:
		ret := %p1%(p2,p3,p4,p5,p6)
		Return
	Func6:
		ret := %p1%(p2,p3,p4,p5,p6,p7)
		Return
	Func7:
		ret := %p1%(p2,p3,p4,p5,p6,p7,p8)
		Return
	Func8: ; Fills role for full 5/2/0 with Upgrade(tower,1,1,1,1,1,2,2)
		ret := %p1%(p2,p3,p4,p5,p6,p7,p8,p9)
		Return
	Func9:
		ret := %p1%(p2,p3,p4,p5,p6,p7,p8,p9,p10) 
		Return
	Func10:
		ret := %p1%(p2,p3,p4,p5,p6,p7,p8,p9,p10,p11) 
		Return
	Func11:
		ret := %p1%(p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12) 
		Return
	Func12: ; Fills role for all 12 with UseSpecialAbility(1,1,1,1,1,1,1,1,1,1,1,1)
		ret := %p1%(p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13)
		Return

	; Suspend, Permit
}

ActiveText(String, VariableNames) {
	OriginalString = %String%
	Loop, Parse, VariableNames, |
		StringReplace, String, String, % "`%" A_LoopField "`%", % %A_LoopField%, All
	IfEqual, OriginalString, %String%
		Return %String%
	Else
		Return ActiveText(String, VariableNames)
}