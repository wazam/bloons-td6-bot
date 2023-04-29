PlayGame() {
	global

	If (CustomScript != "No") {
		Loop, Read, Scripts\%CustomScript%.txt
			ParseCustomScript(A_LoopReadLine)
		Return
	}

	If (Difficulty = "Standard (Easy)") {
		Create("Hero")
		Create("Ninja")
		WatchForRound(3)
		Upgrade("Ninja", 1)
		WatchForRound(5)
		Upgrade("Ninja", 3)
		WatchForRound(7)
		Upgrade("Ninja", 1)
		WatchForRound(10)
		Upgrade("Ninja", 1)
		WatchForRound(19)
		Upgrade("Ninja", 1)
		WatchForRound(21)
		Create("Alchemist")
		WatchForRound(23)
		Upgrade("Alchemist", 1, 1)
		WatchForRound(27)
		Upgrade("Alchemist", 1)
		WatchForRound(33)
		Upgrade("Alchemist", 1)
		WatchForRound(35)
		Upgrade("Alchemist", 2, 2)
		EndsOnRound(40)
	} Else If (Difficulty = "Standard (Medium)") {		; NOT AVALIABLE
	} Else If (Difficulty = "Standard (Hard)") {		; NOT AVALIABLE
	} Else If (Difficulty = "Impoppable") {				; NOT AVALIABLE
	} Else If (Difficulty = "Deflation") {				; NOT AVALIABLE
	} Else If (Difficulty = "Double HP MOABs") {		; NOT AVALIABLE
	} Else If (Difficulty = "Alternate Bloons Round") {	; NOT AVALIABLE
	} Else If (Difficulty = "Reverse") {				; NOT AVALIABLE
	} Else If (Difficulty = "Apopalypse") {				; NOT AVALIABLE
	} Else If (Difficulty = "Half Cash") {				; NOT AVALIABLE
	} Else If (Difficulty = "CHIMPS") {					; NOT AVALIABLE
	} Else If (Difficulty = "Primary Monkeys Only") {	; NOT AVALIABLE
	} Else If (Difficulty = "Military Monkeys Only") {	; NOT AVALIABLE
	} Else If (Difficulty = "Magic Monkeys Only") {		; NOT AVALIABLE
	}
	Return
}