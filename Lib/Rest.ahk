Rest(duration_in_seconds) {
	global
	CustomClick(SafeX, SafeY)
	Sleep, % duration_in_seconds * 1000		; Sleep Function takes milli-seconds as input
	WinActivate, %GameTitle%
	CustomClick(SafeX, SafeY)
	Return
}