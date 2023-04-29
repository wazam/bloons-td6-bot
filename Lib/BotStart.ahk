BotStart() {
	global
	LockGUI()
	WinActivate, %GameTitle%
	If (StartOn = "Main Menu") {
		CustomClick(700,780)				; "Play" on main menu
		AutoClickHero()
		AutoClickMap()
		AutoClickDifficulty()
	}
	AssignMapVariables()
	Loop, %LoopAmount% {
		Sleep, 100
		Send, {SPACE}						; Start round
		Sleep, 20
		Send, {SPACE}						; Speed up round
		PlayGame()
		CustomClick(801,759)				; "Next" in victory pop-up
		Sleep, 1300
		CustomClick(1015,707)				; "Freeplay" in victory pop-up						
		Sleep, 1350							; Wait for freeplay rules pop-up
		CustomClick(802,632)				; "Ok" in free play pop-up
		Sleep, 1300							; Wait for freeplay rules pop-up
		If DebugMode
			SendInput, {F12}				; Screenshot final tower placements on map for analysis
		If (EndOn = "Defeat") {
			Send, {SPACE}					; Resume at double speed
			Rest(420)						; Wait 7 minutes for "Defeat" pop-up
			CustomClick(694, 679)			; "Restart" in defeat pop-up
		} Else {
			SendInput, {Esc}				; Pause menu
			Sleep, 1300						; Wait for pause pop-up
			CustomClick(898, 704)			; "Restart" in victory pop-up
		}
		CustomClick(948, 603)				; "Restart" in restart? pop-up
		Sleep, 1500							; Wait for map to re-load
	}
	ExitApp
}