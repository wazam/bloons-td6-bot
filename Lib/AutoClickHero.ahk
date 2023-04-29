AutoClickHero() {
	global
	BlockInput On
	nextX := 100/1920*ClientWidth
	nextY := 990/1080*ClientHeight
	Click, %nextX% %nextY%					; "Change Hero"
	Sleep, 200
	HeroStepX := Mod(HasVal(OrderedHeros,Hero)-1,3)
	nextX := (100/1920*ClientWidth)+(HeroStepX*(160/1920*ClientWidth))
	HeroStepY := Floor((HasVal(OrderedHeros,Hero)-1)/3)
	nextY := (230/1080*ClientHeight)+(HeroStepY*(190/1080*ClientHeight))
	Click, %nextX% %nextY%					; click Hero
	Sleep, 20
	nextX := 1110/1920*ClientWidth
	nextY := 610/1080*ClientHeight
	Click, %nextX% %nextY%					; "Select"
	Sleep, 20
	SendInput, {Esc}						; back to map menu
	Sleep, 200
	BlockInput Off
	Return
}