WatchForRound(round) {
	global
	WinActivate, %GameTitle%
	CustomClick(SafeX, SafeY)
	If (Resolution = "1600x900") {
		RoundNumberBackgroundPixelX = 1194
		RoundNumberBackgroundPixelY = 52
		RoundNumberSearchX1 = 1190
		RoundNumberSearchY1 = 24
		RoundNumberSearchX2 = 1242
		RoundNumberSearchY2 = 58
	} Else If (Resolution = "1920x1080") {
		RoundNumberBackgroundPixelX = 1432
		RoundNumberBackgroundPixelY = 67
		RoundNumberSearchX1 = 1430
		RoundNumberSearchY1 = 29
		RoundNumberSearchX2 = 1487
		RoundNumberSearchY2 = 70
	}
	Loop {
		PixelGetColor, FoundColor, RoundNumberBackgroundPixelX, RoundNumberBackgroundPixelY, RGB
		ImageSearch, , , RoundNumberSearchX1, RoundNumberSearchY1, RoundNumberSearchX2, RoundNumberSearchY2, *100 *Trans%FoundColor% %A_ScriptDir%\Res\%Resolution%_round_%round%.png
		Sleep, 500 ; 0.5 seconds
	}  until !ErrorLevel
	Return
}