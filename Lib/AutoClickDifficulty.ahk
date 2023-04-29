AutoClickDifficulty() {
	global
	If (Difficulty = "Standard (Easy)" or Difficulty = "Primary Monkeys Only" or Difficulty = "Deflation") {
		CustomClick(518,334)
	} Else If (Difficulty = "Standard (Medium)" or Difficulty = "Military Monkeys Only" or Difficulty = "Apopalypse" or Difficulty = "Reverse") {
		CustomClick(800,334)
	} Else If (Difficulty = "Standard (Hard)" or Difficulty = "Magic Monkeys Only" or Difficulty = "Double HP MOABs" or Difficulty = "Half Cash" or Difficulty = "Alternate Bloons Round" or Difficulty = "Impoppable" or Difficulty = "CHIMPS") {
		CustomClick(1075,334)
	}
	If (Difficulty = "Standard (Easy)" or Difficulty = "Standard (Medium)" or Difficulty = "Standard (Hard)") {
		CustomClick(525,486)
	} Else If (Difficulty = "Primary Monkeys Only" or Difficulty = "Military Monkeys Only" or Difficulty = "Magic Monkeys Only") {
		CustomClick(800,400)
	} Else If (Difficulty = "Reverse" or Difficulty = "Alternate Bloons Round") {
		CustomClick(800,610)
	} Else If (Difficulty = "Deflation" or Difficulty = "Apopalypse" or Difficulty = "Double HP MOABs") {
		CustomClick(1067,400)
	} Else If (Difficulty = "Impoppable") {
		CustomClick(1067,610)
	} Else If (Difficulty = "Half Cash") {
		CustomClick(1337,400)
	} Else If (Difficulty = "CHIMPS") {
		CustomClick(1337,610)
	}
	Sleep, 20
	CustomClick(945,607)					; "Ok" overwirte save popup box
	Sleep, 5000								; Wait for map to load
	CustomClick(800,610)					; "Ok" map rules popup box
	Return
}