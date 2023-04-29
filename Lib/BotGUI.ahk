BotGUI() {
	global

	Gui, Font, cBlack s11 Calibri ; Set default font

	Gui, Add, GroupBox, w280 h85 cBlue, Information:

	Gui, Add, Button, xp+10 yp+20 w80 h25 vInstructions gInfo, Instructions
	Gui, Add, Button, xp+90 yp wp hp vHelp gInfo, Help
	Gui, Add, Button, xp+90 yp wp hp vHints gInfo, Hints
	Gui, Add, Button, xp-180 yp+30 wp hp vScripting gInfo, Scripting
	Gui, Add, Button, xp+90 yp wp hp vAbout gInfo, About
	Gui, Add, Button, xp+90 yp wp hp vLicense gInfo, License

	Gui, Add, GroupBox, xp-190 yp+40 w280 h110 cBlue, Configuration:

	Gui, Add, Text, xp+10 yp+20, Map:
	OrderedMapsArrayTrimmed := OrderedMaps.Clone()
	Loop % OrderedMapsArrayTrimmed.Length()
		For Index, Value In OrderedMapsArrayTrimmed
			If (Value = "")
				OrderedMapsArrayTrimmed.RemoveAt(Index)
	OrderedMapsArrayTrimmedList := ""
	For Index, Value In OrderedMapsArrayTrimmed
		OrderedMapsArrayTrimmedList .= "|" . Value
	OrderedMapsArrayTrimmedList := LTrim(OrderedMapsArrayTrimmedList, "|")
	Gui, Add, DropDownList, xp+94 yp-4 +Sort vMap, %OrderedMapsArrayTrimmedList%
	GuiControl, ChooseString, Map, %DefaultMap%

	Gui, Add, Text, xp-94 yp+34, Difficulty:
	Gui, Add, DropDownList, xp+94 yp-4 vDifficulty, Alternate Bloons Round|Apopalypse|CHIMPS|Deflation|Double HP MOABs|Half Cash|Impoppable|Magic Monkeys Only|Military Monkeys Only|Primary Monkeys Only|Reverse|Standard (Easy)|Standard (Medium)|Standard (Hard)
	GuiControl, ChooseString, Difficulty, %DefaultDifficulty%

	Gui, Add, Text, xp-94 yp+34, Hero:
	OrderedHerosArrayTrimmed := OrderedHeros.Clone()
	For Index, Value In OrderedHerosArrayTrimmed
		If (Value = "")
			OrderedHerosArrayTrimmed.RemoveAt(Index)
	OrderedHerosArrayTrimmedList := ""
	For Index, Value In OrderedHerosArrayTrimmed
		OrderedHerosArrayTrimmedList .= "|" . Value
	OrderedHerosArrayTrimmedList := LTrim(OrderedHerosArrayTrimmedList, "|")
	Gui, Add, DropDownList, xp+94 yp-4 +Sort vHero, %OrderedHerosArrayTrimmedList%
	GuiControl, ChooseString, Hero, %DefaultHero%

	Gui, Add, GroupBox, xp-104 yp+40 w280 h260 cBlue, Preferences:

	Gui, Add, Text, xp+10 yp+20, Start on: ; Skips SelectHero() Map() Difficulty() and Restarts to begin Round 1 ASAP
	Gui, Add, DropDownList, xp+94 yp-4 +Choose1 vStartOn, Main Menu|Map

	Gui, Add, Text, xp-94 yp+34, End on: ; Continue to play extra rounds (for less xp) after completing the map difficulty's objective
	Gui, Add, DropDownList, xp+94 yp-4 +Choose1 vEndOn, Victory|Defeat

	Gui, Add, Text, xp-94 yp+34, Cash Mode:
	Gui, Add, DropDownList, xp+94 yp-4 +Choose1 vCashMode, Regular|Double

	Gui, Add, Text, xp-94 yp+34, Custom Script:
	Gui, Add, DropDownList, xp+94 yp-4 +Choose1 vCustomScript, No
	Loop, %A_ScriptDir%\scripts\*.txt {
		LastDotPos := InStr(A_LoopFileName,".",0,0)  ; get position of last occurrence of "."
		result := SubStr(A_LoopFileName,1,LastDotPos-1)  ; get substring from start to last dot
		GuiControl, , CustomScript, %result%
	}
	Gui, Add, Text, xp-94 yp+34, Resolution:
	Gui, Add, DropDownList, xp+94 yp-4 +Choose1 vResolution, 1600x900|1920x1080

	Gui, Add, Text, xp-94 yp+34, Storefront:
	Gui, Add, DropDownList, xp+94 yp-4 +Choose1 vStorefront, Steam|Epic Games Store|Microsoft Store|BlueStacks

	Gui, Add, Text, xp-94 yp+34, Loop Amount:
	Gui, Add, Edit, xp+94 yp-3 w165 +Number vLoopAmount, 1000

	Gui, Add, CheckBox, xp-94 yp+33 vDebugMode, Debug Mode ; Records screenshots for analysis after each purchase/upgrade

	Gui, Font, Bold
	Gui, Add, Button, xp yp+34 w80 h25 gF2, Start (F2)
	Gui, Add, Button, xp+85 yp w90 h25 gF3, Pause (F3)
	Gui, Add, Button, xp+95 yp w80 h25 gF4, Exit (F4)

	Gui, Show, AutoSize Center, BotTD6
	WinActivate, BotTD6
	Return
}