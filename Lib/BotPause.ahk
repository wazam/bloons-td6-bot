BotPause() {
    If (A_IsPaused) {
		Pause, Off, 1
		Menu, Tray, Rename, 4&, Pause (F3)
	} Else {
		Pause, On, 1
		Menu, Tray, Rename, 4&, Unpause (F3)
	}
    Return
}