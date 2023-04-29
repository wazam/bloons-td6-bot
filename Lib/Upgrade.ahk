Upgrade(tower,upgrade1,upgrade2:=0,upgrade3:=0,upgrade4:=0,upgrade5:=0,upgrade6:=0,upgrade7:=0) { ; capable of upgrading a tower fully in one command
	global
	TowerClick(tower)
	If (upgrade1 = 1) {
		Send, {SC033}						; keyboard key code for ","
	} Else If (upgrade1 = 2) {
		Send, {SC034}						; for "."
	} Else If (upgrade1 = 3) {
		Send, {SC035}						; for "/"
	}
	If (upgrade2 = 1) {
		Send, {SC033}
	} Else If (upgrade2 = 2) {
		Send, {SC034}
	} Else If (upgrade2 = 3) {
		Send, {SC035}
	}
	If (upgrade3 = 1) {
		Send, {SC033}
	} Else If (upgrade3 = 2) {
		Send, {SC034}
	} Else If (upgrade3 = 3) {
		Send, {SC035}
	}
	If (upgrade4 = 1) {
		Send, {SC033}
	} Else If (upgrade4 = 2) {
		Send, {SC034}
	} Else If (upgrade4 = 3) {
		Send, {SC035}
	}
	If (upgrade5 = 1) {
		Send, {SC033}
	} Else If (upgrade5 = 2) {
		Send, {SC034}
	} Else If (upgrade5 = 3) {
		Send, {SC035}
	}
	If (upgrade6 = 1) {
		Send, {SC033}
	} Else If (upgrade6 = 2) {
		Send, {SC034}
	} Else If (upgrade6 = 3) {
		Send, {SC035}
	}
	If (upgrade7 = 1) {
		Send, {SC033}
	} Else If (upgrade7 = 2) {
		Send, {SC034}
	} Else If (upgrade7 = 3) {
		Send, {SC035}
	}
	If DebugMode {
		SendInput, {F12}
	}
	Return
}