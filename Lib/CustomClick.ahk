CustomClick(x_of_1600, y_of_900) {
	global

	nextX := x_of_1600 / 1616 * ClientWidth		; Double Check 1616 vs 1600 performance
	nextY := y_of_900 / 939 * ClientHeight

	BlockInput, On
	Click, %nextX% %nextY%
	BlockInput, Off

	Return
}