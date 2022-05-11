; Read Me
	LastUpdate := "2020-12-04"
	BloonsVersion := "v22.0"
	
/* To Do
	1) Screen OCR reader for in-game money
	2) Work dynamically with all screen sizes
	3) Replace sleep/wait with BlockInput https://www.autohotkey.com/docs/commands/BlockInput.htm
	4) Arrays for Map selection/pages
	5) Arrays for Monkey X&Y coordinates, per Map 
	*/

; Initilization
	; Initilization- Environment
		#SingleInstance force 			; https://www.autohotkey.com/docs/commands/_SingleInstance.htm
		#NoEnv 							; https://www.autohotkey.com/docs/commands/_NoEnv.htm
		SetWorkingDir %A_ScriptDir% 	; https://www.autohotkey.com/docs/commands/SetWorkingDir.htm
		;SetBatchLines -1 				; https://www.autohotkey.com/docs/commands/SetBatchLines.htm
		#WinActivateForce 				; https://www.autohotkey.com/docs/commands/_WinActivateForce.htm
		SetTitleMatchMode, 3 			; https://www.autohotkey.com/docs/commands/SetTitleMatchMode.htm
		global Map,Difficulty,Hero,AdvancedSettings,StartOnMap,Freeplay,DebugMode,LoopAmount,InputDelay,MapLoadTime,PopUpLoadTime
		global DartX,DartY,BoomerangX,BoomerangY,BombX,BombY,TackX,TackY,IceX,IceY,GlueX,GlueY,SniperX,SniperY,SubX,SubY,BuccaneerX,BuccaneerY,AceX,AceY,HeliX,HeliY,MotarX,MotarY,WizardX,WizardY,SuperX,SuperY,NinjaX,NinjaY,AlchemistX,AlchemistY,DruidX,DruidY,FarmX,FarmY,EngineerX,EngineerY,SpikeX,SpikeY,VillageX,VillageY,HeroX,HeroY

	; Initilization- Tray
		If FileExist("C:\Program Files (x86)\Steam\steamapps\common\BloonsTD6\BloonsTD6.exe") {
			TrayIconFile := LoadPicture("C:\Program Files (x86)\Steam\steamapps\common\BloonsTD6\BloonsTD6.exe", "Icon1", io) ; https://www.autohotkey.com/docs/commands/LoadPicture.htm
			#NoTrayIcon 				; https://www.autohotkey.com/docs/commands/_NoTrayIcon.htm
			Menu, Tray, Icon 			; https://www.autohotkey.com/docs/commands/Menu.htm#Icon
			Menu, Tray, Icon, % "HICON:*" TrayIconFile, , 1 ;Menu, Tray, Icon, C:\Users\James\Desktop\icon.ico, , 1
		} Else If FileExist("D:\Program Files (x86)\Steam\steamapps\common\BloonsTD6\BloonsTD6.exe") {
			TrayIconFile := LoadPicture("D:\Program Files (x86)\Steam\steamapps\common\BloonsTD6\BloonsTD6.exe", "Icon1", io) ; https://www.autohotkey.com/docs/commands/LoadPicture.htm
			#NoTrayIcon 				; https://www.autohotkey.com/docs/commands/_NoTrayIcon.htm
			Menu, Tray, Icon 			; https://www.autohotkey.com/docs/commands/Menu.htm#Icon
			Menu, Tray, Icon, % "HICON:*" TrayIconFile, , 1
		}
		Menu, Tray, Click, 1 			; 1 click to open tray menu icon
		Menu, Tray, Add, Show GUI, ShowGui
		Menu, Tray, Default, Show Gui	; Bold "Show GUI" in menu icon options
		Menu, Tray, Add, Hide GUI, HideGui
		Menu, Tray, Add, Start, F2
		Menu, Tray, Add, Exit, F4
		Menu, Tray, NoStandard
		;If A_IsCompiled {}				; https://www.autohotkey.com/docs/Variables.htm#IsCompiled

	; Initilization- GUI- Header
		Gui +Owner 						; https://www.autohotkey.com/docs/commands/Gui.htm#Owner
		Gui, Add, Text, x9 y04 w515 h15 +0x200, Simple auto clicker for Bloons TD 6 %BloonsVersion%, last updated on %LastUpdate% by Wazam.
		Gui, Font, cFF0000 				; https://www.autohotkey.com/docs/commands/Gui.htm#Font
		Gui, Add, Text, x9 y20 w515 h15 +0x200, Game client Screen Size must be 1600x900 (please adjust in settings).
		Gui, Font ; reset font to default
		Gui, Add, Text, x9 y36 w515 h15, Try to not interupt the bot's use of your mouse and keyboard while it is clicking.

	; Initilization- GUI- Step 1
		Gui, Font, s12
		Gui, Font, c0000FF
		Gui, Add, GroupBox, x9 y52 w245 h100, Step 1: Create your build:
		Gui, Font ; reset font to default
		Gui, Add, Text, x12 y77 w81 h21 +0x200, Map:
		Gui, Add, DropDownList, x65 y77 w120 +Disabled vMap, Monkey Meadow|Tree Stump|Town Center|Skates|Lotus Island|Candy Falls|Winter Park|Carved|Park Path|Alpine Run|Frozen Over|In The Loop|Cubism|Four Circles|Hedge|End Of The Road|Logs|Encrypted|Bazaar|Adora's Temple|Spring Spring|KartsNDarts|Moon Landing|Haunted|Downstream|Firing Range|Cracked|Streambed|Chutes|Rake|Spice Islands|X Factor|Mesa|Geared|Spillway|Cargo|Pat's Pond|Peninsula|High Finance|Another Brick|Off The Coast|Cornfield|Underground|Flooded Valley|Infernal|Bloddy Puddles|Workshop|Quad|Dark Castle|Muddy Puddles|#Ouch
		Gui, Add, Text, x12 y101 w79 h23 +0x200, Difficulty:
		Gui, Add, DropDownList, x65 y101 w120 +Disabled vDifficulty, Standard (Easy)|Primary Monkeys Only|Deflation|Standard (Medium)|Military Monkeys Only|Apopalypse|Reverse|Standard (Hard)|Magic Monkeys Only|Double HP MOABs|Half Cash|Alternate Bloons Round|Impoppable|CHIMPS
		Gui, Add, Text, x12 y125 w95 h23 +0x200, Hero:
		Gui, Add, DropDownList, x65 y125 w120 +Disabled vHero, Quincy|Gwendolin|Striker Jones|Obyn Greenfoot|Etienne|Captain Churchhill|Benjamin|Ezili|Pat Fusty|Adora|Admiral Brickell

		Gui, Font, s12
		Gui, Font, c0000FF
		Gui, Add, GroupBox, x264 y52 w245 h175, ... or choose a custom game:
		Gui, Font ; reset font to default
		Gui, Add, Radio, x268 y77 w230 h15 +Checked gCustomBuild1 vCustomBuild1, Dark Castle, Easy, Quincy
		Gui, Add, Radio, x268 y93 w230 h15 gCustomBuild2 vCustomBuild2, Logs, Impoppable, Obyn
		Gui, Add, Radio, x268 y109 w230 h15 +Disabled gCustomBuild3 vCustomBuild3, Logs, Impoppable, Freeplay, Obyn
		Gui, Add, Radio, x268 y125 w230 h15 +Disabled gCustomBuild4 vCustomBuild4, Logs, Easy, Freeplay, Obyn
		Gui, Add, Radio, x268 y141 w230 h15 +Disabled gCustomBuild5 vCustomBuild5, Logs, Easy, Obyn
		Gui, Add, Radio, x268 y157 w230 h15 +Disabled gCustomBuild6 vCustomBuild6, Logs, Impoppable, Freeplay, Debug
		Gui, Add, Radio, x268 y173 w230 h15 +Disabled gCustomBuild7 vCustomBuild7, Logs, Impoppable, Freeplay, Debug, On Map
		Gui, Add, Radio, x268 y189 w230 h15 +Disabled gCustomBuild8 vCustomBuild8, Logs, Impoppable, Debug
		Gui, Add, Radio, x268 y205 w230 h15 +Disabled gCustomBuild9 vCustomBuild9, Logs, Impoppable, Debug, On Map
		Gui, Add, Text, x264 y230 w240 h80, `fDARK CASTLE EASY for holiday event rewards and monkey money (the quickest expert-map). `n`fLOGS IMPOPPABLE for level XP and insta monkey (the easiest map). `n`fFREEPLAY for BADs and Fortified Bloons (rounds 100-120 have x10 rounds 1-100).

	; Initilization- GUI- Step 2
		Gui, Font, s12
		Gui, Font, c0000FF
		Gui, Add, GroupBox, x8 y155 w245 h95, Step 2: Adjust optional settings:
		Gui, Font ; reset font to default
		Gui, Add, CheckBox, x12 y180 w80 h15 gAdvancedSettingsToggle vAdvancedSettings, Advanced ; Enables changing Input/Map/Pop-up Delay values from GUI
		Gui, Add, CheckBox, x12 y196 w80 h15 +Disabled vStartOnMap, Start on Map ; Skips SelectHero() Map() Difficulty() and Restarts to begin Round 1 ASAP
		Gui, Add, CheckBox, x12 y212 w80 h15 +Disabled vFreeplay, Freeplay ; Continue to play extra rounds (for less xp) after completing the map difficulty's objective
		Gui, Add, CheckBox, x12 y228 w80 h15 +Disabled vDebugMode, Debug Mode ; Records screenshots for analysis after each purchase/upgrade

		Gui, Add, Text, x103 y180 w70 h15 +0x200, Loop Amount:
		Gui, Add, Edit, x175 y180 w35 h15 +Number +Disabled vLoopAmount, 1000 ; Amount of times the bot plays the select map
		Gui, Add, Text, x215 y180 w30 h15 +0x200, time(s)

		Gui, Add, Text, x103 y196 w70 h15 +0x200, Input Delay:
		Gui, Add, Edit, x175 y196 w35 h15 +Number +Disabled vInputDelay, 65 ; Used to as help compensate for Input Lag (in milliseconds)
		Gui, Add, Text, x215 y196 w30 h15 +0x200, ms

		Gui, Add, Text, x103 y212 w70 h15 +0x200, Map Delay:
		Gui, Add, Edit, x175 y212 w35 h15 +Number +Disabled vMapLoadTime, 2000 ; Used to help compensate Loading Lag (in milliseconds)
		Gui, Add, Text, x215 y212 w30 h15 +0x200, ms

		Gui, Add, Text, x103 y228 w70 h15 +0x200, Pop-up Delay:
		Gui, Add, Edit, x175 y228 w35 h15 +Number +Disabled vPopUpLoadTime, 650 ; Used to help compensate Animation Delay (in milliseconds)
		Gui, Add, Text, x215 y228 w30 h15 +0x200, ms

	; Initilization- GUI- Step 3
		Gui, Font, s12
		Gui, Font, c0000FF
		Gui, Add, GroupBox, x8 y250 w245 h55, Step 3: Run the bot:
		Gui, Font ; reset font to default
		Gui, Font, Bold
		Gui, Add, Button, x12 y275 w118 h25 gF2, F2 (START)
		Gui, Add, Button, x129 y275 w118 h25 gF4, F4 (EXIT)

		Gui, Show, w517 h311, BotTD6

	; Initilization- Input Delay
		GuiControlGet, InputDelay,, InputDelay ;ControlGetText, InputDelay, %InputDelay%
		SendMode, Event ;Input ; https://www.autohotkey.com/docs/commands/SendMode.htm
		CoordMode, Mouse, Client ; https://www.autohotkey.com/docs/commands/CoordMode.htm
		SetKeyDelay, %InputDelay%, %InputDelay% ; https://www.autohotkey.com/docs/commands/SetKeyDelay.htm
		SetMouseDelay, %InputDelay% ; https://www.autohotkey.com/docs/commands/SetMouseDelay.htm
		SetWinDelay, %InputDelay% ; https://www.autohotkey.com/docs/commands/SetWinDelay.htm

	; Initilization- Launch game client	
		If !WinExist("BloonsTD6") { ; https://www.autohotkey.com/docs/commands/WinExist.htm
			Run, C:\Program Files (x86)\Steam\steamapps\common\BloonsTD6\BloonsTD6.exe ; https://www.autohotkey.com/docs/commands/Run.htm
			GuiControlGet, MapLoadTime,, MapLoadTime
			Sleep, % MapLoadTime * 4 ; Wait for game to update
			WinActivate, BloonsTD6 ; https://www.autohotkey.com/docs/commands/WinActivate.htm
			Click, 810, 820 ; Click to skip to Welcome Screen
			GuiControlGet, PopUpLoadTime,, PopUpLoadTime
			Sleep, % PopUpLoadTime ; Wait for "Play"
			Click, 810, 820 ; "Play"
			;Sleep, % MapLoadTime ; Wait for Main Menu to load
		}

	; Initilization- End
		Gosub CustomBuild1 ; https://www.autohotkey.com/docs/commands/Gosub.htm
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
				GuiControl, Enable, InputDelay
				GuiControl, Enable, MapLoadTime
				GuiControl, Enable, PopUpLoadTime
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
				GuiControl, Text, InputDelay, 65
				GuiControl, Disable, InputDelay
				GuiControl, Text, MapLoadTime, 1996
				GuiControl, Disable, MapLoadTime
				GuiControl, Text, PopUpLoadTime, 650
				GuiControl, Disable, PopUpLoadTime
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
	F4::ExitApp ; https://www.autohotkey.com/docs/commands/ExitApp.htm
	;F3::Pause, Toggle ; https://www.autohotkey.com/docs/commands/Pause.htm
	F2::StartBot()

; Custom Functions
	AutoClickHero() {
		global
		Click, 509, 800 ; "Heroes"
		If (Hero = "Quincy") {
			Click, 110, 820
		} Else If (Hero = "Gwendolin") {
			Click, 280, 820
		} Else If (Hero = "Striker Jones") {
			Click, 460, 820
		} Else If (Hero = "Obyn Greenfoot") {
			Click, 630, 820
		} Else If (Hero = "Etienne") {
			Click, 810, 820
		} Else If (Hero = "Captain Churchhill") {
			Click, 980, 820
		} Else If (Hero = "Benjamin") {
			Click, 1160, 820
		} Else If (Hero = "Ezili") {
			Click, 1350, 820
		} Else If (Hero = "Pat Fusty") {
			Click, 1520, 820
		} Else If (Hero = "Adora") {
			MouseMove, 1350, 820
			Sleep, 100
			Send, {WheelUp 7}
			Sleep, 100
			Click, 1350, 820
		} Else If (Hero = "Admiral Brickell") {
			MouseMove, 1520, 820
			Sleep, 100
			Send, {WheelUp 7}
			Sleep, 100
			Click, 1520, 820
		}
		Click, 530, 560 ; "Select"
		SendInput, {Esc} ; back to Main Menu ; Click, 75,45
		Return
		}

	AutoClickMap() {
		global
		Click, 700, 800 ; "Play"

		;arr_Map_MonkeyMeadow := Object("page", 1, "spot", 1)
		If (Map = "Monkey Meadow" or Map = "Tree Stump" or Map = "Town Center" or Map = "Skates" or Map = "Lotus Island" or Map = "Candy Falls") {
			ClickNextMapPage := 0
		} Else If (Map = "Winter Park" or Map = "Carved" or Map = "Park Path" or Map = "Alpine Run" or Map = "Frozen Over" or Map = "In The Loop") {
			ClickNextMapPage := 1
		} Else If (Map = "Cubism" or Map = "Four Circles" or Map = "Hedge" or Map = "End Of The Road" or Map = "Logs") {
			ClickNextMapPage := 2
		} Else If (Map = "Encrypted" or Map =  "Bazaar" or Map = "Adora's Temple" or Map = "Spring Spring" or Map = "KartsNDarts" or Map = "Moon Landing") {
			ClickNextMapPage := 3
		} Else If (Map = "Haunted" or Map = "Downstream" or Map = "Firing Range" or Map = "Cracked" or Map = "Streambed" or Map = "Chutes") {
			ClickNextMapPage := 4
		} Else If (Map = "Rake" or Map = "Spice Islands") {
			ClickNextMapPage := 5
		} Else If (Map = "X Factor" or Map = "Mesa" or Map = "Geared" or Map = "Spillway" or Map = "Cargo" or Map = "Pat's Pond") {
			ClickNextMapPage := 6
		} Else If (Map = "Peninsula" or Map = "High Finance" or Map = "Another Brick" or Map = "Off The Coast" or Map = "Cornfield" or Map = "Underground") {
			ClickNextMapPage := 7
		} Else If (Map = "Flooder Valley" or Map = "Infernal" or Map = "Bloddy Puddles" or Map = "Workshop" or Map = "Quad" or Map = "Dark Castle") {
			ClickNextMapPage := 8
		} Else If (Map = "Muddy Puddles" or Map = "#Ouch") {
			ClickNextMapPage := 9
		}
		Loop, % ClickNextMapPage
			Click, 1370, 360
		If (Map = "Monkey Meadow" or Map = "Winter Park" or Map = "Cubism" or Map = "Encrypted" or Map = "Haunted" or Map = "Rake"	or Map = "X Factor" or Map = "Peninsula" or Map = "Flooded Valley" or Map = "Muddy Puddles") {
			Click, 450, 200
		} Else If (Map = "Tree Stump" or Map = "Carved" or Map = "Four Circles" or Map = "Bazaar" or Map = "Downstream" or Map = "Spice Islands" or Map = "Mesa" or Map = "High Finance" or Map = "Infernal" or Map = "#Ouch") {
			Click, 800, 200
		} Else If (Map = "Town Center" or Map = "Park Path" or Map = "Hedge" or Map = "Adora's Temple" or Map = "Firing Range" or Map = "Geared" or Map = "Another Brick" or Map = "Bloddy Puddles") {
			Click, 1150, 200
		} Else If (Map = "Skates" or Map = "Alpine Run" or Map = "End Of The Road" or Map = "Spring Spring" or Map = "Cracked" or Map = "Spillway" or Map = "Off The Coast" or Map = "Workshop") {
			Click, 450, 500
		} Else If (Map = "Lotus Island" or Map = "Frozen Over" or Map = "Logs" or Map = "KartsNDarts" or Map = "Streambed" or Map = "Cargo" or Map = "Cornfield" or Map = "Quad") {
			Click, 800, 500
		} Else If (Map = "Candy Falls" or Map = "In The Loop" or Map = "Moon Landing" or Map = "Chutes" or Map = "Pat's Pond" or Map = "Underground" or Map = "Dark Castle") {
			Click, 1150, 500
		}
		Return
		}

	AutoClickDifficulty() {
		global
		If (Difficulty = "Standard (Easy)" or Difficulty = "Primary Monkeys Only" or Difficulty = "Deflation") {
			Click, 518, 334 ; "Easy" game modes
		} Else If (Difficulty = "Standard (Medium)" or Difficulty = "Military Monkeys Only" or Difficulty = "Apopalypse" or Difficulty = "Reverse") {
			Click, 800, 334 ; "Medium" game modes
		} Else If (Difficulty = "Standard (Hard)" or Difficulty = "Magic Monkeys Only" or Difficulty = "Double HP MOABs" or Difficulty = "Half Cash" or Difficulty = "Alternate Bloons Round" or Difficulty = "Impoppable" or Difficulty = "CHIMPS") {
			Click, 1075, 334 ; "Hard" game modes
		}
		If (Difficulty = "Standard (Easy)" or Difficulty = "Standard (Medium)" or Difficulty = "Standard (Hard)") {
			Click, 525, 486 ; Option 1
		} Else If (Difficulty = "Primary Monkeys Only" or Difficulty = "Military Monkeys Only" or Difficulty = "Magic Monkeys Only") {
			Click, 800, 400 ; Option 2a
		} Else If (Difficulty = "Reverse" or Difficulty = "Alternate Bloons Round") {
			Click, 800, 610 ; Option 2b
		} Else If (Difficulty = "Deflation" or Difficulty = "Apopalypse" or Difficulty = "Double HP MOABs") {
			Click, 1067, 400 ; Option 3a
		} Else If (Difficulty = "Impoppable") {
			Click, 1067, 610 ; Option 3b
		} Else If (Difficulty = "Half Cash") {
			Click, 1337, 400 ; Option 4a
		} Else If (Difficulty = "CHIMPS") {
			Click, 1337, 610 ; Option 4b
		}
		Click, 950, 620 ; "Ok" overwirte save popup box
		Sleep, % MapLoadTime ; Wait for map to load
		Click, 800, 610 ; "Ok" map rules popup box
		Return
		}
	AssignMapVariables() {
		global
		If (Map = "Monkey Meadow") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Tree Stump") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Town Center") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Lotus Island") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Candy Falls") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Winter Park") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Carved") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Park Path") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Alpine Run") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Frozen Over") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "In The Loop") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Cubism") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Four Circles") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Hedge") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "End Of The Road") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Logs") {
			SafeX := 458, 		SafeY := 235
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := 483, 		IceY := 487
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := 266, 		HeliY := 586
			MotarX := , 		MotarY := 
			WizardX := 534, 	WizardY := 437
			SuperX := ,			SuperY := 
			NinjaX := 537, 		NinjaY := 488
			;Ninja2X := 		Ninja2Y :=
			AlchemistX := 473, 	AlchemistY := 578
			DruidX := , 		DruidY := 
			FarmX := 261, 		FarmY := 597
			EngineerX := , 		EngineerY := 
			SpikeX := 284, 		SpikeY := 703
			VillageX := 396, 	VillageY := 578
			HeroX := 423, 		HeroY := 485
		} Else If (Map = "Encrypted") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Bazaar") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Adora's Temple") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Spring Spring") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "KartsNDarts") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Moon Landing") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Haunted") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Downstream") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Firing Range") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Cracked") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Streambed") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Chutes") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Rake") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Spice Islands") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Mesa") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Geared") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Spillway") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Cargo") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Pat's Pond") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Peninsula") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "High Finance") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Another Brick") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Off The Coast") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Cornfield") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Underground") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Flooded Valley") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Infernal") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Bloddy Puddles") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Workshop") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Quad") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "Dark Castle") {
			;Array123 := [Safe:[579,97],Hero:[615,560],Ninja:[610,366],Alchemist[480,395]]
			SafeX := 579, 		SafeY := 97
			DartX := , 			DartY :=
			BoomerangX := , 	BoomerangY :=
			BombX := , 			BombY :=
			TackX := , 			TackY :=
			IceX := , 			IceY :=
			GlueX := , 			GlueY :=
			SniperX := , 		SniperY :=
			SubX := , 			SubY :=
			BuccaneerX := , 	BuccaneerY :=
			AceX := , 			AceY :=
			HeliX := , 			HeliY :=
			MotarX := , 		MotarY :=
			WizardX := ,	 	WizardY :=
			SuperX := ,			SuperY :=
			NinjaX := 610, 		NinjaY := 366
			AlchemistX := 480, 	AlchemistY := 395
			DruidX := , 		DruidY :=
			FarmX := , 			FarmY :=
			EngineerX := , 		EngineerY :=
			SpikeX := , 		SpikeY :=
			VillageX := , 		VillageY :=
			HeroX := 615, 		HeroY := 560
		} Else If (Map = "Muddy Puddles") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		} Else If (Map = "#Ouch") {
			SafeX := , 			SafeY := 
			DartX := , 			DartY := 
			BoomerangX := , 	BoomerangY := 
			BombX := , 			BombY := 
			TackX := , 			TackY := 
			IceX := , 			IceY := 
			GlueX := , 			GlueY := 
			SniperX := , 		SniperY := 
			SubX := , 			SubY := 
			BuccaneerX := , 	BuccaneerY := 
			AceX := , 			AceY := 
			HeliX := , 			HeliY := 
			MotarX := , 		MotarY := 
			WizardX := ,	 	WizardY := 
			SuperX := ,			SuperY := 
			NinjaX := , 		NinjaY := 
			AlchemistX := , 	AlchemistY := 
			DruidX := , 		DruidY := 
			FarmX := , 			FarmY := 
			EngineerX := , 		EngineerY := 
			SpikeX := , 		SpikeY := 
			VillageX := , 		VillageY := 
			HeroX := , 			HeroY := 
		}
		Return
		}

	ClickOn(tower) {
		global
		towerX := %tower%X
		towerY := %tower%Y
		Click, %towerX%, %towerY%
		Return
		}

	ClickOff() {
		global
		;BlockInput On
		Click, %SafeX%, %SafeY%
		;BlockInput Off
		Return
		}

	Rest(duration_in_seconds) {
		global
		ClickOff()
		Sleep, % duration_in_seconds * 1000 ; Sleep Function takes milli-seconds as input
		WinActivate, BloonsTD6
		ClickOff()
		Return
		}

	Create(tower) {
		global
		;tower_type := RegExReplace(tower, "[0-9]") ; https://www.autohotkey.com/docs/commands/RegExReplace.htm
		If (tower = "Dart") {
			Send, {Q} ; Dart Monkey
		} Else If (tower = "Boomerang") {
			Send, {W} ; Boomerang Monkey
		} Else If (tower = "Bomb") {
			Send, {E} ; Bomb Shooter
		} Else If (tower = "Tack") {
			Send, {R} ; Tack Shooter
		} Else If (tower = "Ice") {
			Send, {T} ; Ice Monkey
		} Else If (tower = "Glue") {
			Send, {Y} ; Glue Gunner
		} Else If (tower = "Sniper") {
			Send, {Z} ; Sniper Monkey
		} Else If (tower = "Sub") {
			Send, {X} ; Monkey Sub
		} Else If (tower = "Buccaneer") {
			Send, {C} ; Monkey Buccaneer
		} Else If (tower = "Ace") {
			Send, {V} ; Monkey Ace
		} Else If (tower = "Heli") {
			Send, {B} ; Heli Pilot
		} Else If (tower = "Mortar") {
			Send, {N} ; Mortar Monkey
		} Else If (tower = "Wizard") {
			Send, {A} ; Wizard Monkey
		} Else If (tower = "Super") {
			Send, {S} ; Super Monkey
		} Else If (tower = "Ninja") {
			Send, {D} ; Ninja Monkey
		} Else If (tower = "Alchemist") {
			Send, {F} ; Alchemist
		} Else If (tower = "Druid") {
			Send, {G} ; Druid
		} Else If (tower = "Farm") {
			Send, {H} ; Banana Farm
		} Else If (tower = "Engineer") {
			Send, {L} ; Engineer Monkey
		} Else If (tower = "Spike") {
			Send, {J} ; Spike Factory
		} Else If (tower = "Village") {
			Send, {K} ; Monkey Village
		} Else If (tower = "Hero") {
			Send, {U} ; Heroes
		}
		ClickOn(tower)
		If DebugMode
			SendInput, {F12}
		Return
		}

	Upgrade(tower,upgrade1,upgrade2,upgrade3,upgrade4,upgrade5,upgrade6,upgrade7) {
		global
		ClickOn(tower)
		If (upgrade1 = 1) {
			Send, {SC033}
		} Else If (upgrade1 = 2) {
			Send, {SC034}
		} Else If (upgrade1 = 3) {
			Send, {SC035}
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

	StartBot() {
		global
		Gui, Submit
		
		; no chnages to GUI after F2/Start
			GuiControl, Disable, Map
			GuiControl, Disable, Difficulty
			GuiControl, Disable, Hero
			GuiControl, Disable, Freeplay
			GuiControl, Disable, StartOnMap
			GuiControl, Disable, DebugMode
			GuiControl, Disable, AdvancedSettings
			GuiControl, Disable, LoopAmount
			GuiControl, Disable, InputDelay
			GuiControl, Disable, MapLoadTime
			GuiControl, Disable, PopUpLoadTime
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
			GuiControlGet, InputDelay,, InputDelay
			GuiControlGet, MapLoadTime,, MapLoadTime
			GuiControlGet, PopUpLoadTime,, PopUpLoadTime

		WinActivate, BloonsTD6
		If Not StartOnMap {
			AutoClickHero()
			AutoClickMap()
			AutoClickDifficulty()
		}
		AssignMapVariables()
		Loop, %LoopAmount% {
			Send, {SPACE} 									; Start round
			Send, {SPACE} 									; Speed up round
			PlayRounds()
			
			Click, 800, 760									; "Next" in victory pop-up
			Sleep, % PopUpLoadTime / 5
			Click, 930, 700									; "Freeplay" in victory pop-up
			Sleep, % PopUpLoadTime							; Wait for freeplay rules pop-up
			SendInput, {Esc}								; Close freeplay rules pop-up ;Click, 791, 596
			Sleep, % PopUpLoadTime							; Wait for freeplay rules pop-up
			If DebugMode
				SendInput, {F12}							; Screenshot final tower placements on map for analysis
			
			If Freeplay {
				Send, {SPACE}								; Resume at double speed
				Rest(420) 									; Wait 7 minutes for "Defeat" pop-up 
				Click, 851, 625 							; "Restart" in defeat pop-up
				Click, 851, 625 							; "Restart" in restart? pop-up
			} Else {
				SendInput, {Esc} 							; Pause menu
				Sleep, % PopUpLoadTime 						; Wait for pause pop-up
				Click, 900, 700 							; "Restart" in victory pop-up
				Click, 950, 600 							; "Restart" in restart? pop-up
			}
			Sleep, % MapLoadTime / 2						; Wait for map to re-load
		}
		ExitApp
		}

	PlayRounds() {
		global
		If (Difficulty = "Standard (Easy)") {
			Create("Hero") 									; Hero Round 1
			If Not (Hero = "Quincy")
				Rest(10)									; adjust for higher Hero cost leaving less $ for upgrades [rough estimate of 10 seconds]
			Create("Ninja")									; 0/0/0 Ninja Round 1
			Rest(16) ;lock
			Upgrade("Ninja",1,"","","","","","") 			; 1/0/0 Ninja Round 3
			Rest(14) ;lock
			Upgrade("Ninja",3,"","","","","","") 			; 1/0/1 Ninja Round 5
			Rest(13)
			Upgrade("Ninja",1,"","","","","","")			; 2/0/1 Ninja Round 7
			Rest(37)
			Upgrade("Ninja",1,"","","","","","")			; 3/0/1 Ninja Round 10
			Rest(89)
			Upgrade("Ninja",1,"","","","","","") 			; 4/0/1 Ninja Round 19
			Rest(7)
			Create("Alchemist") 							; 0/0/0 Alchemist Round 21
			Rest(3)
			Upgrade("Alchemist",1,"","","","","","") 		; 1/0/0 Alchemist Round 24
			Rest(3)
			Upgrade("Alchemist",1,"","","","","","") 		; 2/0/0 Alchemist Round 25
			Rest(22)
			Upgrade("Alchemist",1,"","","","","","") 		; 3/0/0 Alchemist Round 27
			Rest(40) ;lock
			Upgrade("Alchemist",1,"","","","","","") 		; 4/0/0 Alchemist Round 33
			Rest(12) ;lock
			Upgrade("Alchemist",3,"","","","","","") 		; 4/0/1 Alchemist Round 34
			Rest(4)
			Upgrade("Alchemist",3,"","","","","","") 		; 4/0/2 Alchemist Round 34
			Rest(3)
			Upgrade("Ninja",3,"","","","","","") 			; 4/0/2 Ninja Round 35
			Rest(78)										; Wait for victory pop-up Round 40
		} Else If (Difficulty = "Standard (Medium)") {
			;
		} Else If (Difficulty = "Standard (Hard)") {
			;
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
				Upgrade("Farm",1,1,3,3,3,"","") 			; 2/0/3 Farm
				Rest(8)
			}
			Upgrade("Alchemist",1,"","","","","","")		; 3/0/0 Alchemist Round 34
			Rest(35) ;lock
			Upgrade("Alchemist",1,"","","","","","") 		; 4/0/0 Alchemist Round 37
			Rest(6) ;lock
			Upgrade("Alchemist",3,"","","","","","")		; 4/0/1 Alchemist Round 38
			Rest(3) ;lock
			Upgrade("Alchemist",3,"","","","","","") 		; 4/0/2 Alchemist Round 38
			Rest(3) ;lock
			Upgrade("Ninja",3,"","","","","","")			; 4/0/2 Ninja Round 38(40!)
			Rest(281) ;lock
			Upgrade("Ninja",1,"","","","","","") 			; 5/0/2 Ninja Round 62(63!)
			Rest(10) ;lock
			Create("Village") 								; 0/0/0 Village Round 63
			Rest(3)
			Upgrade("Village",1,"","","","","","")			; 1/0/0 Village Round 63
			Rest(5) ;lock
			Upgrade("Village",1,"","","","","","")			; 2/0/0 Village Round 64
			Rest(2)
			Upgrade("Village",2,"","","","","","")			; 2/1/0 Village Round 65
			Rest(21) ;lock
			Upgrade("Village",2,"","","","","","") 			; 2/2/0 Village Round 65
			Rest(71) ;lock
			Upgrade("Village",2,"","","","","","") 			; 2/3/0 Village Round 72
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
			Sleep, % PopUpLoadTime * 3						; Wait for victory pop-up Round 100
			/* Heli
				Create("Heli") 								; 0/0/0 Heli Round 6
					Rest(3)
				Upgrade("Heli",1,"","","","","","") 		; 1/0/0 Heli Round 6
					Rest(5)
				Upgrade("Heli",1,"","","","","","") 		; 2/0/0 Heli Round 6
					Rest(1)
				Upgrade("Heli",2,"","","","","","") 		; 2/1/0 Heli Round 6
					Rest(1)
				Upgrade("Heli",2,"","","","","","") 		; 2/2/0 Heli Round 6
					Rest(20)
				Upgrade("Heli",1,"","","","","","") 		; 3/2/0 Heli Round 6
					Rest(188)
				Upgrade("Heli",1,"","","","","","") 		; 4/2/0 Heli Round 7
					Rest(260)
				Upgrade("Heli",1,"","","","","","") 		; 5/2/0 Heli Round 9
				*/
			/* Wizard
				Create("Wizard") 							; 0/0/0 Wizard Round 100
					Rest(120)
				Upgrade("Wizard",1,1,1,1,3,3,"") 			; 4/0/2 Wizard Round 100
					Rest(240)
				Upgrade("Wizard",1,"","","","","","") 		; 5/0/2 Wizard Round 114
				*/
		} Else If (Difficulty = "Deflation") {
			Send, {K} ; Village_1 0-0-2
			Sleep, 500
			Click 777, 388
			Sleep, 500
			Click 777, 388
			Sleep, 500
			Loop, 2
			{
			Send, {SC035}
			Sleep, 500
			}
			Click, 750, 100
			Sleep, 500

			Send, {U} ; Hero
			Sleep, 500
			;Click, 585, 379
			Click, 615, 395
			Sleep, 500
			Click, 750, 100
			Sleep, 500

			Send, {W} ; Boomerang 0-2-4
			Sleep, 500
			Click, 683, 394
			Sleep, 500
			Click, 683, 394
			Sleep, 500
			Loop, 2
			{
			Send, {SC034}
			Sleep, 500
			}
			Loop, 4
			{
			Send, {SC035}
			Sleep, 500
			}
			Click, 750, 100
			Sleep, 500

			Send, {X} ; Sub 2-0-3
			Sleep, 500
			Click, 915, 388
			Sleep, 500
			Click, 915, 388
			Sleep, 500
			Loop, 2
			{
			Send, {SC033}
			Sleep, 500
			}
			Loop, 3
			{
			Send, {SC035}
			Sleep, 500
			}
			Click, 750, 100
			Sleep, 500

			Send, {X} ; Sub 2-3-0
			Sleep, 500
			Click, 915, 326
			Sleep, 500
			Click, 915, 326
			Sleep, 500
			Loop, 2
			{
			Send, {SC033}
			Sleep, 500
			}
			Loop, 3
			{
			Send, {SC034}
			Sleep, 500
			}
			Click, 750, 100
			Sleep, 500

			Click, 777, 388
			Sleep, 500
			Click, 282, 793 ; SELL Village_1
			Sleep, 500
			Click, 750, 100
			Sleep, 500

			Send, {K} ; Village_2 2-0-0
			Sleep, 500
			Click, 777, 388
			Sleep, 500
			Click, 777, 388
			Sleep, 500
			Loop, 2
			{
			Send, {SC033}
			Sleep, 500
			}
			Click, 750, 100
			Sleep, 500

			Send, {J} ; Spike Factory 0-2-4
			Sleep, 500
			Click, 1277, 492
			Sleep, 500
			Click, 1277, 492
			Sleep, 500
			Loop, 2
			{
			Send, {SC034}
			Sleep, 500
			}
			Loop, 4
			{
			Send, {SC035}
			Sleep, 500
			}
			Click, 750, 100
			Sleep, 500

			Send, {F} ; Alchemist 3-0-0
			Sleep, 500
			Click, 1284, 429
			Sleep, 500
			Click, 1284, 429
			Sleep, 500
			Loop, 3
			{
			Send, {SC033}
			Sleep, 500
			}
			Click, 750, 100
			Sleep, 500

			Send, {Q} ; Dart Monkey 0-1-2
			Sleep, 500
			Click, 414, 665
			Sleep, 500
			Click, 414, 665
			Sleep, 500
			Loop, 1
			{
			Send, {SC034}
			Sleep, 500
			}
			Loop, 2
			{
			Send, {SC035}
			Sleep, 500
			}
			Click, 750, 100
			Sleep, 500

			Send, {SPACE} ; Start round
			Sleep, 500
			Send, {SPACE} ; Speed up
			Sleep, 500

			Sleep, 380000 ; Wait for Victory popup
		} Else If (Difficulty = "Double HP MOABs") {
			Send, {U}
			Click, 422, 450
			Sleep, 17000

			Send, {D}
			Click, 526, 453 ; 0-0-0 Ninja

				Click, 605, 83
				Sleep, 20000
				Click, 605, 83

			Click, 526, 453
			Send, {SC033} ; 1-0-0 Ninja

				Click, 605, 83
				Sleep, 65000
				Click, 605, 83

			Click, 526, 453
			Send, {SC033}
			Send, {SC035} ; 2-0-1 Ninja

				Click, 605, 83
				Sleep, 15000F
				Click, 605, 83

			Click, 526, 453
			Send, {SC033} ; 3-0-1 Ninja

				Click, 605, 83
				Sleep, 20000
				Click, 605, 83

			Send, {F}
			Click, 527, 505 ; 0-0-0 Alchemist

				Click, 605, 83
				Sleep, 20000
				Click, 605, 83

			Click, 527, 505
			Send, {SC033}
			Send, {SC033} ; 2-0-0 Alchemist

				Click, 605, 83
				Sleep, 60000
				Click, 605, 83

			Click, 526, 453
			Send, {SC033} ; 4-0-1 Ninja

				Click, 605, 83
				Sleep, 15000
				Click, 605, 83

			Click, 527, 505
			Send, {SC033} ; 3-0-0 Alchemist

				Click, 605, 83
				Sleep, 35000
				Click, 605, 83

			Click, 527, 505
			Send, {SC035}
			Send, {SC035} ; 3-0-2 Alchemist

				Click, 605, 83
				Sleep, 25000
				Click, 605, 83

			Click, 527, 505
			Send, {SC033} ; 4-0-2 Alchemist

				Click, 605, 83
				Sleep, 15000
				Click, 605, 83

			Click, 526, 453,
			Send, {SC035} ; 4-0-2 Ninja

				Click, 605, 83
				Sleep, 260000 ; save for grandmaster ninja before 60 around 59
				Click, 605, 83

			Click, 526, 453
			Send, {SC033} ; 5-0-2 Ninja

				Click, 605, 83
				Sleep, 3650000 ; wait for Victory popup
		} Else If (Difficulty = "Alternate Bloons Round") {
					
			Send, {U}
			Click, 422, 450
			Sleep, 17000

			Send, {D}
			Click, 526, 453 ; 0-0-0 Ninja

				Click, 605, 83
				Sleep, 20000
				Click, 605, 83

			Click, 526, 453
			Send, {SC033} ; 1-0-0 Ninja

				Click, 605, 83
				Sleep, 65000
				Click, 605, 83

			Click, 526, 453
			Send, {SC033}
			Send, {SC035} ; 2-0-1 Ninja

				Click, 605, 83
				Sleep, 15000F
				Click, 605, 83

			Click, 526, 453
			Send, {SC033} ; 3-0-1 Ninja

				Click, 605, 83
				Sleep, 20000
				Click, 605, 83

			Send, {F}
			Click, 527, 505 ; 0-0-0 Alchemist

				Click, 605, 83
				Sleep, 20000
				Click, 605, 83

			Click, 527, 505
			Send, {SC033}
			Send, {SC033} ; 2-0-0 Alchemist

				Click, 605, 83
				Sleep, 60000
				Click, 605, 83

			Click, 526, 453
			Send, {SC033} ; 4-0-1 Ninja

				Click, 605, 83
				Sleep, 15000
				Click, 605, 83

			Click, 527, 505
			Send, {SC033} ; 3-0-0 Alchemist

				Click, 605, 83
				Sleep, 35000
				Click, 605, 83

			Click, 527, 505
			Send, {SC035}
			Send, {SC035} ; 3-0-2 Alchemist

				Click, 605, 83
				Sleep, 25000
				Click, 605, 83

			Click, 527, 505
			Send, {SC033} ; 4-0-2 Alchemist

				Click, 605, 83
				Sleep, 15000
				Click, 605, 83

			Click, 526, 453,
			Send, {SC035} ; 4-0-2 Ninja

				Click, 605, 83
				Sleep, 280000 ; save for grandmaster ninja around 57
				Click, 605, 83

			Click, 526, 453
			Send, {SC033} ; 5-0-2 Ninja

				Click, 605, 83
				Sleep, 3800000 ; wait for Victory popup
		} Else If (Difficulty = "Reverse") {
			;
		} Else If (Difficulty = "Apopalypse") {
			;
		} Else If (Difficulty = "Half Cash") {
			;
		} Else If (Difficulty = "CHIMPS") {
			;
		} Else If (Difficulty = "Primary Monkeys Only") {
			;
		} Else If (Difficulty = "Military Monkeys Only") {
			;
		} Else If (Difficulty = "Magic Monkeys Only") {
			;
		}
		Return
		}