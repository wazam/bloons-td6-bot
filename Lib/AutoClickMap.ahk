AutoClickMap() {
	global
	ClickNextMapPage := Floor((HasVal(OrderedMaps,Map)-1)/6)
	ClickMap := Mod(HasVal(OrderedMaps,Map),6)
	Loop, % ClickNextMapPage {
		nextX := 1644/1920*ClientWidth
		nextY := 428/1080*ClientHeight
		Click, %nextX% %nextY%
	}
	If (ClickMap = 1) {
		nextX := 540/1920*ClientWidth
		nextY := 250/1080*ClientHeight
	} Else If (ClickMap = 2) {
		nextX := 960/1920*ClientWidth
		nextY := 250/1080*ClientHeight
	} Else If (ClickMap = 3) {
		nextX := 1380/1920*ClientWidth
		nextY := 250/1080*ClientHeight
	} Else If (ClickMap = 4) {
		nextX := 540/1920*ClientWidth
		nextY := 570/1080*ClientHeight
	} Else If (ClickMap = 5) {
		nextX := 960/1920*ClientWidth
		nextY := 570/1080*ClientHeight
	} Else If (ClickMap = 0) {
		nextX := 1380/1920*ClientWidth
		nextY := 570/1080*ClientHeight
	}
	Click, %nextX% %nextY%
	Return
}