; unused function

UseSpecialAbility(slot1,slot2:=0,slot3:=0,slot4:=0,slot5:=0,slot6:=0,slot7:=0,slot8:=0,slot9:=0,slot10:=0,slot11:=0,slot12:=0) { ; capable of using all hotkeys for special abilities in one command
	global
	If (slot1 = 1) {
		Send, {SC002}						; keyboard key code for "1"
	}
	If (slot2 = 1) {
		Send, {SC003}						; for "2"
	}
	If (slot3 = 1) {
		Send, {SC004}						; for "3"
	}
	If (slot4 = 1) {
		Send, {SC005}						; for "4"
	}
	If (slot5 = 1) {
		Send, {SC006}						; for "5"
	}
	If (slot6 = 1) {
		Send, {SC007}						; for "6"
	}
	If (slot7 = 1) {
		Send, {SC008}						; for "7"
	}
	If (slot8 = 1) {
		Send, {SC009}						; for "8"
	}
	If (slot9 = 1) {
		Send, {SC00A}						; for "9"
	}
	If (slot10 = 1) {
		Send, {SC00B}						; for "0"
	}
	If (slot11 = 1) {
		Send, {SC00C}						; for "-"
	}
	If (slot12 = 1) {
		Send, {SC00D}						; for "="
	}
	Return
}