/* Update these variables for game updates
	1) MapListOrdered
	2) HeroListOrdered
	3) vMap
	4) vHero
	*/
	LastUpdateDate := "2022-02-22"
	LastBloonsVersion := "v30.1.5016"

/* To do
	1) Arrays for Monkey X&Y cords, per Map, per Difficulty ; https://www.autohotkey.com/docs/Objects.htm#Usage_Simple_Arrays ; https://www.autohotkey.com/docs/misc/Arrays.htm
	2) Replace sleep/wait with BlockInput		; https://www.autohotkey.com/docs/commands/BlockInput.htm
	3) Screen OCR reader for in-game money(?)	; https://www.autohotkey.com/docs/commands/ImageSearch.htm
	*/

; Initilization
	; Initilization- Environment
		#SingleInstance force					; https://www.autohotkey.com/docs/commands/_SingleInstance.htm
		#NoEnv									; https://www.autohotkey.com/docs/commands/_NoEnv.htm
		SetWorkingDir %A_ScriptDir%				; https://www.autohotkey.com/docs/commands/SetWorkingDir.htm
		;SetBatchLines -1						; https://www.autohotkey.com/docs/commands/SetBatchLines.htm
		#WinActivateForce						; https://www.autohotkey.com/docs/commands/_WinActivateForce.htm
		SetTitleMatchMode, 3					; https://www.autohotkey.com/docs/commands/SetTitleMatchMode.htm
		global Map,Difficulty,Hero,AdvancedSettings,StartOnMap,Freeplay,DebugMode,LoopAmount,ClientWidth,ClientHeight,nextX,nextY
		global DartX,DartY,BoomerangX,BoomerangY,BombX,BombY,TackX,TackY,IceX,IceY,GlueX,GlueY,SniperX,SniperY,SubX,SubY,BuccaneerX,BuccaneerY,AceX,AceY,HeliX,HeliY,MortarX,MortarY,DartlingX,DartlingY,WizardX,WizardY,SuperX,SuperY,NinjaX,NinjaY,Ninja2X,Ninja2Y,AlchemistX,AlchemistY,DruidX,DruidY,FarmX,FarmY,EngineerX,EngineerY,SpikeX,SpikeY,VillageX,VillageY,HeroX,HeroY
		global MapListOrdered := ["Monkey Meadow","Tree Stump","Town Center","The Cabin","Resort","Skates","Lotus Island","Candy Falls","Winter Park","Carved","Park Path","Alpine Run","Frozen Over","In The Loop","Cubism","Four Circles","Hedge","End Of The Road","Logs","","","","","","Quiet Street","Bloonarius Prime","Balance","Encrypted","Bazaar","Adora's Temple","Spring Spring","KartsNDarts","Moon Landing","Haunted","Downstream","Firing Range","Cracked","Streambed","Chutes","Rake","Spice Islands","","Sunken Columns","X Factor","Mesa","Geared","Spillway","Cargo","Pat's Pond","Peninsula","High Finance","Another Brick","Off The Coast","Cornfield","Underground","","","","","","Sanctuary","Ravine","Flooded Valley","Infernal","Bloddy Puddles","Workshop","Quad","Dark Castle","Muddy Puddles","#Ouch","",""]
		global HeroListOrdered := ["Quincy","Gwendolin","Striker Jones","Obyn Greenfoot","Psi","Captain Churchhill","Benjamin","Ezili","Pat Fusty","Adora","Admiral Brickell","Etienne","Sauda"]

	; Initilization- Tray
		Menu, Tray, Click, 1					; 1 click to open tray menu icon
		Menu, Tray, Add, Show GUI, ShowGui
		Menu, Tray, Default, Show Gui			; Bold "Show GUI" in menu icon options
		Menu, Tray, Add, Hide GUI, HideGui
		Menu, Tray, Add, Start, F2
		Menu, Tray, Add, Pause (10s.), F3
		Menu, Tray, Add, Exit, F4
		#NoTrayIcon								; https://www.autohotkey.com/docs/commands/_NoTrayIcon.htm
		Menu, Tray, Icon						; https://www.autohotkey.com/docs/commands/Menu.htm#Icon
		Menu, Tray, NoStandard
		If A_IsCompiled	{						; https://www.autohotkey.com/docs/Variables.htm#IsCompiled
			If FileExist("C:\Program Files (x86)\Steam\steamapps\common\BloonsTD6\BloonsTD6.exe") {
				TrayIconFile := LoadPicture("C:\Program Files (x86)\Steam\steamapps\common\BloonsTD6\BloonsTD6.exe", "Icon1", io) ; https://www.autohotkey.com/docs/commands/LoadPicture.htm
			} Else If FileExist("D:\Program Files (x86)\Steam\steamapps\common\BloonsTD6\BloonsTD6.exe") {
				TrayIconFile := LoadPicture("D:\Program Files (x86)\Steam\steamapps\common\BloonsTD6\BloonsTD6.exe", "Icon1", io)
			}
				#NoTrayIcon
				Menu, Tray, Icon, % "HICON:*" TrayIconFile, , 1
		}

	; Initilization- GUI- Header
		Gui +Owner								; https://www.autohotkey.com/docs/commands/Gui.htm#Owner
		Gui, Add, Text, x9 y04 w515 h15 +0x200, Simple auto clicker for Bloons TD 6 (%LastBloonsVersion%), last updated on %LastUpdateDate% by Wazam.
		Gui, Add, Text, x9 y20 w515 h15 +0x200, Launch BloonsTD6 to main menu, then launch the bot.
		Gui, Font, cFF0000						; https://www.autohotkey.com/docs/commands/Gui.htm#Font
		Gui, Add, Text, x9 y36 w515 h15, Please do not interupt the bot's use of your mouse and keyboard while it is clicking.
		Gui, Font								; reset font to default

	; Initilization- GUI- Step 1
		Gui, Font, s12
		Gui, Font, c0000FF
		Gui, Add, GroupBox, x9 y52 w245 h100, Step 1: Create your build:
		Gui, Font								; reset font to default
		Gui, Add, Text, x12 y77 w81 h21 +0x200, Map:
		Gui, Add, DropDownList, x65 y77 w120 +Disabled vMap, Adora's Temple|Alpine Run|Another Brick|Balance|Bazaar|Bloddy Puddles|Bloonarius Prime|Candy Falls|Cargo|Carved|Chutes|Cornfield|Cracked|Cubism|Dark Castle|Downstream|Encrypted|End Of The Road|Firing Range|Flooded Valley|Four Circles|Frozen Over|Geared|Haunted|Hedge|High Finance|In The Loop|Infernal|KartsNDarts|Logs|Lotus Island|Mesa|Monkey Meadow|Moon Landing|Muddy Puddles|Off The Coast|Park Path|Pat's Pond|Peninsula|Quad|Quiet Street|Rake|Ravine|Resort|Sanctuary|Skates|Spice Islands|Spillway|Spring Spring|Streambed|Sunken Columns|The Cabin|Town Center|Tree Stump|Underground|Winter Park|Workshop|X Factor|#Ouch
		Gui, Add, Text, x12 y101 w79 h23 +0x200, Difficulty:
		Gui, Add, DropDownList, x65 y101 w120 +Disabled vDifficulty, Alternate Bloons Round|Apopalypse|CHIMPS|Deflation|Double HP MOABs|Half Cash|Impoppable|Magic Monkeys Only|Military Monkeys Only|Primary Monkeys Only|Reverse|Standard (Easy)|Standard (Medium)|Standard (Hard)
		Gui, Add, Text, x12 y125 w95 h23 +0x200, Hero:
		Gui, Add, DropDownList, x65 y125 w120 +Disabled vHero, Admiral Brickell|Adora|Benjamin|Captain Churchhill|Etienne|Ezili|Gwendolin|Obyn Greenfoot|Pat Fusty|Psi|Quincy|Sauda|Striker Jones

		Gui, Font, s12
		Gui, Font, c0000FF
		Gui, Add, GroupBox, x264 y52 w245 h175, ... or choose a custom game:
		Gui, Font								; reset font to default
		Gui, Add, Radio, x268 y77 w230 h15 +Checked gCustomBuild1 vCustomBuild1, Dark Castle, Easy, Quincy
		Gui, Add, Radio, x268 y93 w230 h15 gCustomBuild2 vCustomBuild2, Logs, Impoppable, Obyn
		Gui, Add, Radio, x268 y109 w230 h15 +Disabled gCustomBuild3 vCustomBuild3, Logs, Impoppable, Freeplay, Obyn
		Gui, Add, Radio, x268 y125 w230 h15 +Disabled gCustomBuild4 vCustomBuild4, Logs, Easy, Freeplay, Obyn
		Gui, Add, Radio, x268 y141 w230 h15 +Disabled gCustomBuild5 vCustomBuild5, Logs, Easy, Obyn
		Gui, Add, Radio, x268 y157 w230 h15 +Disabled gCustomBuild6 vCustomBuild6, Logs, Impoppable, Freeplay, Debug
		Gui, Add, Radio, x268 y173 w230 h15 +Disabled gCustomBuild7 vCustomBuild7, Logs, Impoppable, Freeplay, Debug, On Map
		Gui, Add, Radio, x268 y189 w230 h15 +Disabled gCustomBuild8 vCustomBuild8, Logs, Impoppable, Debug
		Gui, Add, Radio, x268 y205 w230 h15 +Disabled gCustomBuild9 vCustomBuild9, Logs, Impoppable, Debug, On Map
		Gui, Add, Text, x264 y230 w240 h80, `fDARK CASTLE EASY for holiday event rewards and monkey money (the quickest expert-map). `n`fLOGS IMPOPPABLE for level XP and insta monkey (the easiest map). `n`fFREEPLAY for BADs, DDTs, and Fortified Bloons (rounds 100-120 have x10 rounds 1-100).

	; Initilization- GUI- Step 2
		Gui, Font, s12
		Gui, Font, c0000FF
		Gui, Add, GroupBox, x8 y155 w245 h95, Step 2: Adjust optional settings:
		Gui, Font								; reset font to default
		Gui, Add, CheckBox, x12 y180 w80 h15 gAdvancedSettingsToggle vAdvancedSettings, Advanced ; Enables changing Input/Map/Pop-up Delay values from GUI
		Gui, Add, CheckBox, x12 y196 w80 h15 +Disabled vStartOnMap, Start on Map ; Skips SelectHero() Map() Difficulty() and Restarts to begin Round 1 ASAP
		Gui, Add, CheckBox, x12 y212 w80 h15 +Disabled vFreeplay, Freeplay ; Continue to play extra rounds (for less xp) after completing the map difficulty's objective
		Gui, Add, CheckBox, x12 y228 w80 h15 +Disabled vDebugMode, Debug Mode ; Records screenshots for analysis after each purchase/upgrade

		Gui, Add, Text, x103 y180 w70 h15 +0x200, Loop Amount:
		Gui, Add, Edit, x175 y180 w35 h15 +Number +Disabled vLoopAmount, 1000 ; Amount of times the bot plays the select map
		Gui, Add, Text, x215 y180 w30 h15 +0x200, time(s)

	; Initilization- GUI- Step 3
		Gui, Font, s12
		Gui, Font, c0000FF
		Gui, Add, GroupBox, x8 y250 w245 h55, Step 3: Run the bot:
		Gui, Font								; reset font to default
		Gui, Font, Bold
		Gui, Add, Button, x12 y275 w118 h25 gF2, F2 (START)
		Gui, Add, Button, x129 y275 w118 h25 gF4, F4 (EXIT)

		Gui, Show, w517 h311, BotTD6

	; Initilization- Input Delay
		SendMode, Event ;Input					; https://www.autohotkey.com/docs/commands/SendMode.htm
		CoordMode, Mouse, Client				; https://www.autohotkey.com/docs/commands/CoordMode.htm
		SetKeyDelay, 65, 65						; https://www.autohotkey.com/docs/commands/SetKeyDelay.htm
		SetMouseDelay, 65						; https://www.autohotkey.com/docs/commands/SetMouseDelay.htm
		SetWinDelay, 65							; https://www.autohotkey.com/docs/commands/SetWinDelay.htm

	/*  Initilization- Launch game client	
		If !WinExist("BloonsTD6") {				; https://www.autohotkey.com/docs/commands/WinExist.htm
			Run, C:\Program Files (x86)\Steam\steamapps\common\BloonsTD6\BloonsTD6.exe ; https://www.autohotkey.com/docs/commands/Run.htm
			Sleep, 10000						; Wait for game to update
			WinActivate, BloonsTD6				; https://www.autohotkey.com/docs/commands/WinActivate.htm
			CustomClick(810, 820)				; Click to skip to Welcome Screen
			Sleep, 650							; Wait for "Play"
			CustomClick(810, 820)				; "Play"
		}
		*/

	; Initilization- End
		Gosub CustomBuild1						; https://www.autohotkey.com/docs/commands/Gosub.htm
		WinActivate, BotTD6
		Return

	; GUI Functions
		GuiEscape:
		GuiClose:
			ExitApp
		ShowGui:
			Gui, Show,, BotTD6
			Return
		HideGui:
			Gui, Cancel
			Return
		AdvancedSettingsToggle:
			If Not AdvancedSettings {
				GuiControl, Enable, DebugMode
				GuiControl, Enable, Freeplay
				GuiControl, Enable, StartOnMap
				GuiControl, Enable, LoopAmount
				GuiControl, Enable, CustomBuild3
				GuiControl, Enable, CustomBuild4
				GuiControl, Enable, CustomBuild5
				GuiControl, Enable, CustomBuild6
				GuiControl, Enable, CustomBuild7
				GuiControl, Enable, CustomBuild8
				GuiControl, Enable, CustomBuild9
				GuiControl, Enable, Map
				GuiControl, Enable, Difficulty
				GuiControl, Enable, Hero
			} Else If AdvancedSettings {
				GuiControl,, DebugMode, 0
				GuiControl, Disable, DebugMode
				GuiControl,, Freeplay, 0
				GuiControl, Disable, Freeplay
				GuiControl,, StartOnMap, 0
				GuiControl, Disable, StartOnMap
				GuiControl, Text, LoopAmount, 1000
				GuiControl, Disable, LoopAmount
				
				GuiControl, , CustomBuild9, 0
				GuiControl, Disable, CustomBuild9
				GuiControl, , CustomBuild8, 0
				GuiControl, Disable, CustomBuild8
				GuiControl, , CustomBuild7, 0
				GuiControl, Disable, CustomBuild7
				GuiControl, , CustomBuild6, 0
				GuiControl, Disable, CustomBuild6
				GuiControl, , CustomBuild5, 0
				GuiControl, Disable, CustomBuild5
				GuiControl, , CustomBuild4, 0
				GuiControl, Disable, CustomBuild4
				GuiControl, , CustomBuild3, 0
				GuiControl, Disable, CustomBuild3
				GuiControl, , CustomBuild2, 0
				GuiControl, , CustomBuild1, 1

				GuiControl, ChooseString, Map, Dark Castle
				GuiControl, Disable, Map
				GuiControl, ChooseString, Difficulty, Standard (Easy)
				GuiControl, Disable, Difficulty
				GuiControl, ChooseString, Hero, Quincy
				GuiControl, Disable, Hero
			}
			AdvancedSettings := !AdvancedSettings
			Return
		
	; GUI Custom Builds
		CustomBuild1:
			GuiControl, ChooseString, Map, Dark Castle
			GuiControl, ChooseString, Difficulty, Standard (Easy)
			GuiControl, ChooseString, Hero, Quincy
			GuiControl,, Freeplay, 0
			GuiControl,, StartOnMap, 0
			GuiControl,, DebugMode, 0
			Return
		CustomBuild2:
			GuiControl, ChooseString, Map, Logs
			GuiControl, ChooseString, Difficulty, Impoppable
			GuiControl, ChooseString, Hero, Obyn Greenfoot
			GuiControl,, Freeplay, 0
			GuiControl,, StartOnMap, 0
			GuiControl,, DebugMode, 0
			Return
		CustomBuild3:
			GuiControl, ChooseString, Map, Logs
			GuiControl, ChooseString, Difficulty, Impoppable
			GuiControl, ChooseString, Hero, Obyn Greenfoot
			GuiControl,, Freeplay, 1
			GuiControl,, StartOnMap, 0
			GuiControl,, DebugMode, 0
			Return
		CustomBuild4:
			GuiControl, ChooseString, Map, Logs
			GuiControl, ChooseString, Difficulty, Standard (Easy)
			GuiControl, ChooseString, Hero, Obyn Greenfoot
			GuiControl,, Freeplay, 1
			GuiControl,, StartOnMap, 0
			GuiControl,, DebugMode, 0
			Return
		CustomBuild5:
			GuiControl, ChooseString, Map, Logs
			GuiControl, ChooseString, Difficulty, Standard (Easy)
			GuiControl, ChooseString, Hero, Obyn Greenfoot
			GuiControl,, Freeplay, 0
			GuiControl,, StartOnMap, 0
			GuiControl,, DebugMode, 0
			Return
		CustomBuild6:
			GuiControl, ChooseString, Map, Logs
			GuiControl, ChooseString, Difficulty, Impoppable
			GuiControl, ChooseString, Hero, Obyn Greenfoot
			GuiControl,, Freeplay, 1
			GuiControl,, StartOnMap, 0
			GuiControl,, DebugMode, 1
			Return
		CustomBuild7:
			GuiControl, ChooseString, Map, Logs
			GuiControl, ChooseString, Difficulty, Impoppable
			GuiControl, ChooseString, Hero, Obyn Greenfoot
			GuiControl,, Freeplay, 1
			GuiControl,, StartOnMap, 1
			GuiControl,, DebugMode, 1
			Return
		CustomBuild8:
			GuiControl, ChooseString, Map, Logs
			GuiControl, ChooseString, Difficulty, Impoppable
			GuiControl, ChooseString, Hero, Obyn Greenfoot
			GuiControl,, Freeplay, 0
			GuiControl,, StartOnMap, 0
			GuiControl,, DebugMode, 1
			Return
		CustomBuild9:
			GuiControl, ChooseString, Map, Logs
			GuiControl, ChooseString, Difficulty, Impoppable
			GuiControl, ChooseString, Hero, Obyn Greenfoot
			GuiControl,, Freeplay, 0
			GuiControl,, StartOnMap, 1
			GuiControl,, DebugMode, 1
			Return

; Hotkeys
	F4::ExitApp									; https://www.autohotkey.com/docs/commands/ExitApp.htm
	F3::Sleep, 10000							; https://www.autohotkey.com/docs/commands/Sleep.htm
	F2::StartBot()

; Custom Functions
	AutoClickHero() {
		global
		CustomClick(82,828)						; "Change Hero"
		Sleep, 200
		BlockInput On
		nextX := 108/1920*ClientWidth			; started grabbing cordinates from fullscreen 1920x1080 mode
		nextY := 975/1080*ClientHeight
		MouseMove, %nextX%, %nextY%				; https://www.autohotkey.com/docs/commands/MouseMove.htm
		heroSpacing := 220/1920*ClientWidth		; '175/1600' was old value
		If (HasVal(HeroListOrdered,Hero) > 6) {	; after "Captain Churchhill"
			Sleep, 20
			wheelUpAmount := 4*(HeroListOrdered.Length()-6)
			Send, {WheelUp %wheelUpAmount%}
			heroStarting := 1734/1920*ClientWidth
			nextX := heroStarting + heroSpacing * (HasVal(HeroListOrdered,Hero)-HeroListOrdered.Length()) ; subtracts from last spot
		} Else If (HasVal(HeroListOrdered,Hero) <= 6) { ; "Captain Churchhill" and before
			heroStarting := 108/1920*ClientWidth
			nextX := heroStarting + heroSpacing * (HasVal(HeroListOrdered,Hero)-1) ; adds from first spot
		}
		Click, %nextX% %nextY%					; last cordinates grabbed from fullscreen 1920x1080 mode
		BlockInput Off
		Sleep, 20
		CustomClick(525,555)					; "Select" 
		Sleep, 20
		SendInput, {Esc}						; back to map menu
		Sleep, 200
		Return
		}

	AutoClickMap() {
		global
		ClickNextMapPage := Floor((HasVal(MapListOrdered,Map)-1)/6)
		ClickMap := Mod(HasVal(MapListOrdered,Map),6)
		Loop, % ClickNextMapPage
			CustomClick(1370,360)
		If (ClickMap = 1) {
			CustomClick(450,200)
		} Else If (ClickMap = 2) {
			CustomClick(800,200)
		} Else If (ClickMap = 3) {
			CustomClick(1150,200)
		} Else If (ClickMap = 4) {
			CustomClick(450,500)
		} Else If (ClickMap = 5) {
			CustomClick(800,500)
		} Else If (ClickMap = 0) {
			CustomClick(1150,500)
		}
		Return
		}
	
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
	
	HasVal(haystack, needle) {					; https://www.autohotkey.com/boards/viewtopic.php?p=109617&sid=a057c8ab901a3ab88f6304b71729c892#p109617
		if !(IsObject(haystack)) || (haystack.Length() = 0)
			return 0
		for index, value in haystack
			if (value = needle)
				return index
		return 0
		}

	AssignMapVariables() {
		global
		If (Map = "Monkey Meadow") {
			SafeX := 962,		SafeY := 50
			HeroX := 407,		HeroY := 434
			DartX := ,			DartY := 
			BoomerangX := ,		BoomerangY := 
			BombX := ,			BombY := 
			TackX := ,			TackY := 
			IceX := ,			IceY := 
			GlueX := ,			GlueY := 
			SniperX := ,		SniperY := 
			SubX := ,			SubY := 
			BuccaneerX := ,		BuccaneerY := 
			AceX := ,			AceY := 
			HeliX := ,			HeliY := 
			MortarX := ,		MortarY := 
			DartlingX := ,		DartlingY := 
			WizardX := ,		WizardY :=
			SuperX := ,			SuperY :=
			NinjaX := 524,		NinjaY := 426
			Ninja2X :=			Ninja2Y :=
			AlchemistX := 526,	AlchemistY := 330
			DruidX := ,			DruidY := 
			FarmX := ,			FarmY := 
			SpikeX := ,			SpikeY := 
			VillageX := ,		VillageY := 
			EngineerX := ,		EngineerY := 
		} Else If (Map = "Tree Stump") {		; NOT AVALIABLE
		} Else If (Map = "Town Center") {		; NOT AVALIABLE
		} Else If (Map = "The Cabin") {			; NOT AVALIABLE
		} Else If (Map = "Resort") {			; NOT AVALIABLE
		} Else If (Map = "Skates") {			; NOT AVALIABLE
		} Else If (Map = "Lotus Island") {		; NOT AVALIABLE
		} Else If (Map = "Candy Falls") {		; NOT AVALIABLE
		} Else If (Map = "Winter Park") {		; NOT AVALIABLE
		} Else If (Map = "Carved") {			; NOT AVALIABLE
		} Else If (Map = "Park Path") {			; NOT AVALIABLE
		} Else If (Map = "Alpine Run") {		; NOT AVALIABLE
		} Else If (Map = "Frozen Over") {		; NOT AVALIABLE
		} Else If (Map = "In The Loop") {		; NOT AVALIABLE
		} Else If (Map = "Cubism") {			; NOT AVALIABLE
		} Else If (Map = "Four Circles") {		; NOT AVALIABLE
		} Else If (Map = "Hedge") {				; NOT AVALIABLE
		} Else If (Map = "End Of The Road") {	; NOT AVALIABLE
		} Else If (Map = "Logs") {
			SafeX := 458,		SafeY := 235
			HeroX := 423,		HeroY := 485
			IceX := 483,		IceY := 487
			HeliX := 266,		HeliY := 586
			WizardX := 534,		WizardY := 437
			NinjaX := 537,		NinjaY := 488
			AlchemistX := 473,	AlchemistY := 578
			FarmX := 261,		FarmY := 597
			SpikeX := 284,		SpikeY := 703
			VillageX := 396,	VillageY := 578
		} Else If (Map = "Quiet Street") {
			SafeX := 711,		SafeY := 36
			HeroX := 389,		HeroY := 594
			NinjaX := 476,		NinjaY := 330
			AlchemistX := 420,	AlchemistY := 329
			VillageX := 433,	VillageY := 256
		} Else If (Map = "Bloonarius Prime") {	; NOT AVALIABLE
		} Else If (Map = "Balance") {			; NOT AVALIABLE
		} Else If (Map = "Encrypted") {			; NOT AVALIABLE
		} Else If (Map = "Bazaar") {			; NOT AVALIABLE
		} Else If (Map = "Adora's Temple") {	; NOT AVALIABLE
		} Else If (Map = "Spring Spring") {		; NOT AVALIABLE
		} Else If (Map = "KartsNDarts") {		; NOT AVALIABLE
		} Else If (Map = "Moon Landing") {		; NOT AVALIABLE
		} Else If (Map = "Haunted") {			; NOT AVALIABLE
		} Else If (Map = "Downstream") {		; NOT AVALIABLE
		} Else If (Map = "Firing Range") {		; NOT AVALIABLE
		} Else If (Map = "Cracked") {			; NOT AVALIABLE
		} Else If (Map = "Streambed") {			; NOT AVALIABLE
		} Else If (Map = "Chutes") {			; NOT AVALIABLE
		} Else If (Map = "Rake") {				; NOT AVALIABLE
		} Else If (Map = "Spice Islands") {		; NOT AVALIABLE
		} Else If (Map = "Sunken Columns") {	; NOT AVALIABLE
		} Else If (Map = "X Factor") {			; NOT AVALIABLE
		} Else If (Map = "Mesa") {				; NOT AVALIABLE
		} Else If (Map = "Geared") {			; NOT AVALIABLE
		} Else If (Map = "Spillway") {			; NOT AVALIABLE
		} Else If (Map = "Cargo") {				; NOT AVALIABLE
		} Else If (Map = "Pat's Pond") {		; NOT AVALIABLE
		} Else If (Map = "Peninsula") {			; NOT AVALIABLE
		} Else If (Map = "High Finance") {		; NOT AVALIABLE
		} Else If (Map = "Another Brick") {		; NOT AVALIABLE
		} Else If (Map = "Off The Coast") {		; NOT AVALIABLE
		} Else If (Map = "Cornfield") {			; NOT AVALIABLE
		} Else If (Map = "Underground") {		; NOT AVALIABLE
		} Else If (Map = "Sanctuary") {			; NOT AVALIABLE
		} Else If (Map = "Ravine") {			; NOT AVALIABLE
		} Else If (Map = "Flooded Valley") {	; NOT AVALIABLE
		} Else If (Map = "Infernal") {			; NOT AVALIABLE
		} Else If (Map = "Bloddy Puddles") {	; NOT AVALIABLE
		} Else If (Map = "Workshop") {			; NOT AVALIABLE
		} Else If (Map = "Quad") {				; NOT AVALIABLE
		} Else If (Map = "Dark Castle") {		;MapCords := [Safe:[579,97],Hero:[615,560],Ninja:[610,366],Alchemist[480,395]]
			SafeX := 579,		SafeY := 97
			HeroX := 615,		HeroY := 560
			NinjaX := 610,		NinjaY := 366
			AlchemistX := 480,	AlchemistY := 395
		} Else If (Map = "Muddy Puddles") {		; NOT AVALIABLE
		} Else If (Map = "#Ouch") {				; NOT AVALIABLE
		}
		Return
		}
	
	CustomClick(x_of_1600,y_of_900) {
		global
		nextX := x_of_1600/1616*ClientWidth
		nextY := y_of_900/939*ClientHeight
		BlockInput On
		Click, %nextX% %nextY%
		BlockInput Off
		Return
		}
	
	TowerClick(tower) {
		global
		towerX := %tower%X
		towerY := %tower%Y
		CustomClick(towerX,towerY)
		Return
		}

	Rest(duration_in_seconds) {
		global
		CustomClick(SafeX,SafeY)
		Sleep, % duration_in_seconds * 1000		; Sleep Function takes milli-seconds as input
		WinActivate, BloonsTD6
		CustomClick(SafeX,SafeY)
		Return
		}

	Create(tower) {								;tower_type := RegExReplace(tower, "[0-9]") ; https://www.autohotkey.com/docs/commands/RegExReplace.htm
		global
		BlockInput On
		If (tower = "Dart") {
			Send, {q}							; Dart Monkey
		} Else If (tower = "Boomerang") {
			Send, {w}							; Boomerang Monkey
		} Else If (tower = "Bomb") {
			Send, {e}							; Bomb Shooter
		} Else If (tower = "Tack") {
			Send, {r}							; Tack Shooter
		} Else If (tower = "Ice") {
			Send, {t}							; Ice Monkey
		} Else If (tower = "Glue") {
			Send, {y}							; Glue Gunner
		} Else If (tower = "Sniper") {
			Send, {z}							; Sniper Monkey
		} Else If (tower = "Sub") {
			Send, {x}							; Monkey Sub
		} Else If (tower = "Buccaneer") {
			Send, {c}							; Monkey Buccaneer
		} Else If (tower = "Ace") {
			Send, {v}							; Monkey Ace
		} Else If (tower = "Heli") {
			Send, {b}							; Heli Pilot
		} Else If (tower = "Mortar") {
			Send, {n}							; Mortar Monkey
		} Else If (tower = "Dartling") {
			Send, {m}							; Dartling Gunner
		} Else If (tower = "Wizard") {
			Send, {a}							; Wizard Monkey
		} Else If (tower = "Super") {
			Send, {s}							; Super Monkey
		} Else If (tower = "Ninja") {
			Send, {d}							; Ninja Monkey
		} Else If (tower = "Alchemist") {
			Send, {f}							; Alchemist
		} Else If (tower = "Druid") {
			Send, {g}							; Druid
		} Else If (tower = "Farm") {
			Send, {h}							; Banana Farm
		} Else If (tower = "Engineer") {
			Send, {l}							; Engineer Monkey
		} Else If (tower = "Spike") {
			Send, {j}							; Spike Factory
		} Else If (tower = "Village") {
			Send, {k}							; Monkey Village
		} Else If (tower = "Hero") {
			Send, {u}							; Heroes
		}
		BlockInput Off
		TowerClick(tower)							; Places tower
		If DebugMode
			SendInput, {F12}					; Screenshot
		If (tower = "Hero") {					; Added delay for other heros' higher purchase costs
			If (Hero = "Captain Churchhill") {	; $2000
				Sleep, 146000
			} Else If (Hero = "Benjamin") {		; $1200
				Sleep, 66000
			} Else If (Hero = "Adora") {		; $1000
				Sleep, 46000
			} Else If (Hero = "Gwendolin") {	; $900
				Sleep, 36000
			} Else If (Hero = "Etienne") {		; $850
				Sleep, 31000
			} Else If (Hero = "Psi" or Hero = "Pat Fusty") { ; $800
				Sleep, 26000
			} Else If (Hero = "Striker Jones" or Hero = "Admiral Brickell") { ; $750
				Sleep, 21000
			} Else If (Hero = "Obyn Greenfoot") { ; $650
				Sleep, 11000
			} Else If (Hero = "Ezili" or Hero = "Sauda") { ; $600
				Sleep, 6000
			} Else If (Hero = "Quincy") {		; $540
				Sleep, 1000
			}
		}
		Return
		}

	Upgrade(tower,upgrade1,upgrade2,upgrade3,upgrade4,upgrade5,upgrade6,upgrade7) { ; capable of upgrading a tower fully in one command
		global
		TowerClick(tower)
		If (upgrade1 = 1) {
			Send, {SC033}						; keyboard key codes for ","
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
		If DebugMode
			SendInput, {F12}
		Return
		}
	
	LockGUI(){
		global
		WinGetPos,,,ClientWidth,ClientHeight,BloonsTD6
		Gui, Submit								; no changes to GUI after Start
		GuiControl, Disable, Map
		GuiControl, Disable, Difficulty
		GuiControl, Disable, Hero
		GuiControl, Disable, Freeplay
		GuiControl, Disable, StartOnMap
		GuiControl, Disable, DebugMode
		GuiControl, Disable, AdvancedSettings
		GuiControl, Disable, LoopAmount
		GuiControl, Disable, CustomBuild1
		GuiControl, Disable, CustomBuild2
		GuiControl, Disable, CustomBuild3
		GuiControl, Disable, CustomBuild4
		GuiControl, Disable, CustomBuild5
		GuiControl, Disable, CustomBuild6
		GuiControl, Disable, CustomBuild7
		GuiControl, Disable, CustomBuild8
		GuiControl, Disable, CustomBuild9
		GuiControlGet, Freeplay,, Freeplay
		GuiControlGet, StartOnMap,, StartOnMap
		GuiControlGet, DebugMode,, DebugMode
		GuiControlGet, LoopAmount,, LoopAmount
		}	
	
	StartBot() {
		global
		LockGUI()
		WinActivate, BloonsTD6
		If Not StartOnMap {										
			CustomClick(700,780)				; "Play" on main menu
			AutoClickHero()
			AutoClickMap()
			AutoClickDifficulty()
		}
		AssignMapVariables()
		Loop, %LoopAmount% {
			Sleep, 100
			Send, {SPACE}						; Start round
			Sleep, 20
			Send, {SPACE}						; Speed up round
			PlayRounds()
			CustomClick(801,759)				; "Next" in victory pop-up
			Sleep, 1300
			CustomClick(1015,707)				; "Freeplay" in victory pop-up						
			Sleep, 1350							; Wait for freeplay rules pop-up
			CustomClick(802,632)				; "Ok" in free play pop-up
			Sleep, 1300							; Wait for freeplay rules pop-up
			If DebugMode
				SendInput, {F12}				; Screenshot final tower placements on map for analysis
			If Freeplay {
				Send, {SPACE}					; Resume at double speed
				Rest(420)						; Wait 7 minutes for "Defeat" pop-up
				CustomClick(694,679)			; "Restart" in defeat pop-up
			} Else {
				SendInput, {Esc}				; Pause menu
				Sleep, 1300						; Wait for pause pop-up
				CustomClick(898,704)			; "Restart" in victory pop-up
			}
			CustomClick(948,603)				; "Restart" in restart? pop-up
			Sleep, 1500							; Wait for map to re-load
		}
		ExitApp
		}

	PlayRounds() {
		global
		If (Difficulty = "Standard (Easy)") {
			Create("Hero")									; Hero Round 1
			Create("Ninja")									; 0/0/0 Ninja Round 1 $425
			Rest(16) ;lock
			Upgrade("Ninja",1,"","","","","","")			; 1/0/0 Ninja Round 3 $255
			Rest(11) ;lock
			Upgrade("Ninja",3,"","","","","","")			; 1/0/1 Ninja Round 5 $210
			Rest(12)
			Upgrade("Ninja",1,"","","","","","")			; 2/0/1 Ninja Round 7 $295
			Rest(35) ;lock
			Upgrade("Ninja",1,"","","","","","")			; 3/0/1 Ninja Round 10 $620
			Rest(96)
			Upgrade("Ninja",1,"","","","","","")			; 4/0/1 Ninja Round 19 $2335
			Rest(5)
			Create("Alchemist")								; 0/0/0 Alchemist Round 21 $
			Rest(3)
			Upgrade("Alchemist",1,"","","","","","")		; 1/0/0 Alchemist Round 23 $
			Rest(4)
			Upgrade("Alchemist",1,"","","","","","")		; 2/0/0 Alchemist Round 24 $
			Rest(20)
			Upgrade("Alchemist",1,"","","","","","")		; 3/0/0 Alchemist Round 27 $
			Rest(40) ;lock
			Upgrade("Alchemist",1,"","","","","","")		; 4/0/0 Alchemist Round 33 $2550
			Rest(7) ;lock
			Upgrade("Alchemist",2,"","","","","","")		; 4/1/0 Alchemist Round 34
			Rest(9)
			Upgrade("Alchemist",2,"","","","","","")		; 4/2/0 Alchemist Round 34
			Rest(5)
			Upgrade("Ninja",3,"","","","","","")			; 4/0/2 Ninja Round 35
			Rest(80)										; Wait for victory pop-up Round 40
		} Else If (Difficulty = "Standard (Medium)") {
			Create("Hero")										; Hero Round 1
			Rest(20)
			Create("Ninja")										; 0/0/0 Ninja Round 3
			Rest(13)
			Upgrade("Ninja",1,"","","","","","")				; 1/0/0 Ninja Round 5
			Rest(16)
			Upgrade("Ninja",3,"","","","","","")				; 1/0/1 Ninja Round 7
			Rest(18)
			Upgrade("Ninja",1,"","","","","","")				; 2/0/1 Ninja Round 8
			Rest(37)
			Upgrade("Ninja",1,"","","","","","")				; 3/0/1 Ninja Round 12
			Rest(80)
			Upgrade("Ninja",1,"","","","","","")				; 4/0/1 Ninja Round 23
			Rest(11)
			Create("Alchemist")									; 0/0/0 Alchemist Round 26
			Rest(3)
			Upgrade("Alchemist",1,"","","","","","")			; 1/0/0 Alchemist Round 26
			Rest(3)
			Upgrade("Alchemist",1,"","","","","","")			; 2/0/0 Alchemist Round 27
			Rest(29)
			Upgrade("Alchemist",1,"","","","","","")			; 3/0/0 Alchemist Round 29
			Rest(53)
			Upgrade("Alchemist",1,"","","","","","")			; 4/0/0 Alchemist Round 35
			Rest(5)
			Upgrade("Alchemist",3,"","","","","","")			; 4/0/1 Alchemist Round 36
			Rest(3)
			Upgrade("Alchemist",3,"","","","","","")			; 4/0/2 Alchemist Round 37
			Rest(3)
			Upgrade("Ninja",3,"","","","","","")				; 4/0/2 Ninja Round 38(40!)
			Rest(11)
			Create("Village")									; 0/0/0 Village Round 38
			Rest(5)
			Upgrade("Village",1,"","","","","","")				; 1/0/0 Village Round 38
			Rest(10)
			Upgrade("Village",1,"","","","","","")				; 2/0/0 Village Round 39
			Rest(4)
			Upgrade("Village",2,"","","","","","")				; 2/1/0 Village Round 39
			Rest(15)
			Upgrade("Village",2,"","","","","","")				; 2/2/0 Village Round 41
			Rest(47)
			Upgrade("Village",2,"","","","","","")				; 2/3/0 Village Round 48
			Rest(200)											; Wait for victory pop-up Round 60
		} Else If (Difficulty = "Standard (Hard)") {		; NOT AVALIABLE
		} Else If (Difficulty = "Impoppable") {
			Create("Hero")									; Hero Round 6
			Rest(30)
			Create("Ninja")									; 0/0/0 Ninja Round 9
			Rest(13) ;lock
			Upgrade("Ninja",1,"","","","","","")			; 1/0/0 Ninja Round 10
			Rest(16) ;lock
			Upgrade("Ninja",3,"","","","","","")			; 1/0/1 Ninja Round 12
			Rest(22)
			Upgrade("Ninja",1,"","","","","","")			; 2/0/1 Ninja Round 14
			Rest(27) ;lock
			Upgrade("Ninja",1,"","","","","","")			; 3/0/1 Ninja Round 18
			Rest(68) ;lock
			Upgrade("Ninja",1,"","","","","","")			; 4/0/1 Ninja Round 28
			Rest(8) ;lock
			Create("Alchemist")								; 0/0/0 Alchemist Round 30
			Rest(3)
			Upgrade("Alchemist",1,"","","","","","")		; 1/0/0 Alchemist Round 31
			Rest(3) ;lock
			Upgrade("Alchemist",1,"","","","","","")		; 2/0/0 Alchemist Round 31
			Rest(29) ;lock
			If Freeplay {
				Create("Farm")
				Rest(57)
				Upgrade("Farm",1,1,3,3,3,"","")			; 2/0/3 Farm
				Rest(8)
			}
			Upgrade("Alchemist",1,"","","","","","")		; 3/0/0 Alchemist Round 34
			Rest(35) ;lock
			Upgrade("Alchemist",1,"","","","","","")		; 4/0/0 Alchemist Round 37
			Rest(6) ;lock
			Upgrade("Alchemist",3,"","","","","","")		; 4/0/1 Alchemist Round 38
			Rest(3) ;lock
			Upgrade("Alchemist",3,"","","","","","")		; 4/0/2 Alchemist Round 38
			Rest(3) ;lock
			Upgrade("Ninja",3,"","","","","","")			; 4/0/2 Ninja Round 38(40!)
			Rest(281) ;lock
			Upgrade("Ninja",1,"","","","","","")			; 5/0/2 Ninja Round 62(63!)
			Rest(10) ;lock
			Create("Village")								; 0/0/0 Village Round 63
			Rest(3)
			Upgrade("Village",1,"","","","","","")			; 1/0/0 Village Round 63
			Rest(5) ;lock
			Upgrade("Village",1,"","","","","","")			; 2/0/0 Village Round 64
			Rest(2)
			Upgrade("Village",2,"","","","","","")			; 2/1/0 Village Round 65
			Rest(21) ;lock
			Upgrade("Village",2,"","","","","","")			; 2/2/0 Village Round 65
			Rest(71) ;lock
			Upgrade("Village",2,"","","","","","")			; 2/3/0 Village Round 72
			Rest(2)
			Create("Ice")									; 0/0/0 Ice Round 73
			Rest(50) ;lock
			Upgrade("Ice",2,2,3,3,3,3,"")					; 0/2/4 Ice Round 75
			Rest(180)
			Upgrade("Ice",3,"","","","","","")				; 0/2/5 Ice Round 84
			Rest(265)
			If Freeplay
				Upgrade("Alchemist",1,"","","","","","")	; 5/0/2 Alchemist Round 98
			Else
				Rest(65)									; Balancing for time spent buidling bank
			Rest(80)										; Wait for insta monkey pop-up Round 100
			Sleep, 2500										; Wait for victory pop-up Round 100
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