BotTray() {
	global

	path1 := ["C:\" , "D:\"]
	path2 := ["Program Files\", "Program Files (x86)\"]
	path3 := ["Steam\steamapps\common\", "Epic Games\"]
	path4 := "BloonsTD6\BloonsTD6.exe"

	For index1, element1 In Path1 {
		For i2, e2 In Path2 {
			For i3, e3 In Path3 {
				If FileExist(Path1[index1] Path2[i2] Path3[i3] Path4)
					Menu, Tray, Icon, % Path1[index1] Path2[i2] Path3[i3] Path4, 1, 1
			}
		}
	}

	Menu, Tray, NoStandard
	Menu, Tray, Click, 1
	Menu, Tray, Add, Open (F1), F1
	Menu, Tray, Default, 1&
	Menu, Tray, Add, , , +Break
	Menu, Tray, Add, Start (F2), F2
	Menu, Tray, Add, Pause (F3), F3
	Menu, Tray, Add, Reload (F5), F5
	Menu, Tray, Add, Get Coords (F6), F6
	Menu, Tray, Add, , , +Break
	Menu, Tray, Add, Exit (F4), F4

	Return
}