EndsOnRound(round) {
	; global
	WatchForRound(round)
	Rest(10)					; Wait for final round bloons to be cleaned up
	Return
}