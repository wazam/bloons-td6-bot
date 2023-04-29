LockGUI() {
	global

	Gui, Submit								; no changes to GUI after Start
	GuiControl, Disable, Map
	GuiControl, Disable, Difficulty
	GuiControl, Disable, Hero
	GuiControl, Disable, StartOn
	GuiControlGet, StartOn, , StartOn
	GuiControl, Disable, EndOn
	GuiControlGet, EndOn, , EndOn
	GuiControl, Disable, CashMode
	GuiControlGet, CashMode, , CashMode
	GuiControl, Disable, CustomScript
	GuiControlGet, CustomScript, , CustomScript
	GuiControl, Disable, Resolution
	GuiControlGet, Resolution, , Resolution
	GuiControl, Disable, Storefront
	GuiControlGet, Storefront, , Storefront
	GuiControl, Disable, LoopAmount
	GuiControlGet, LoopAmount, , LoopAmount
	GuiControl, Disable, DebugMode
	GuiControlGet, DebugMode, , DebugMode

	If (Storefront = "Steam") {
		GameTitle = BloonsTD6
	} Else If (Storefront = "Epic Games Store") {
		GameTitle = BloonsTD6-Epic
	} Else If (Storefront = "Microsoft Store") {
		GameTitle = BloonsTD6				; un-tested
	} Else If (Storefront = "BlueStacks") {
		GameTitle = BlueStacks				; un-tested
	}

	If (WinExist(GameTitle) = 0) {
		Msgbox, 16, Runtime error, Error: No game found running.`nNow quitting.
		ExitApp
	}
	WinGetPos, , , ClientWidth, ClientHeight, %GameTitle%

	Return
}