Info() {
	global
	type = %A_GuiControl%
	If (type = "About") {
		message = BotTD6 v%UpdateDate% by wazam`n`nTested with Bloons TD 6 v%BloonsVersion%`n`nAuto clicker script for monkey money and collection events.
	} Else If (type = "Instructions") {
		message = 1. Launch Bloons TD 6 to the main menu.`n2. Choose your gameplay configuration.`n3. Adjust default preferences if necessary.`n4. Start the bot ('F2' key works too).`n5. Exit anytime with 'F4'.
	} Else If (type = "License") {
		message = License, MIT License`n`nCopyright (c) 2020-2023 wazam`n`nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:`n`nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.`n`nTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	} Else If (type = "Hints") {
		message = `fDark Castle on Easy for holiday collection event rewards/crates and monkey money (the quickest expert-map). Deflation is good too here, but it takes longer to complete and event rewards from completing Deflation Mode were specifically nerfed.`n`n`fLogs on Impoppable for profile level XP and simpliest success at round 100 insta monkey (the easiest map).`n`n`fPlaying past game victory/completion until defeat when losing all your lives helps with pop-counts for BADs, DDTs, and Fortified Bloons (rounds 100-120 have x10 rounds 1-100).
	} Else If (type = "Scripting") {
		message = The 'Custom Script' preference below enables you to use your own botting instructions.`n`nFollow the template inside the /scripts/ subfolder to create your own formulas for success.`n`nDon't forget to adjust the configurations (for map, difficulty, and hero) and other preferences too before starting the bot.`n`nPlease restart the bot if you do not see you script in the drop down list.`n`nFile extension must be .txt
	} Else If (type = "Help") {
		message = Please do not interupt the bot's use of your mouse and keyboard while it is actively moving/clicking in the game client window. But while the bot is waiting between rounds, you may freely use your PC.`n`nGame client must alwasy be visible on display screen and not covered by other windows.`n`nCertain in-game pop-ups (like those from leveling up or unlocking monkey knowledge) may break the bot.`n`nOnly tested with full/completed monkey knowledge.`n`nRequires default hotkeys.
	}
	MsgBox, 64, %type%, %message%
	Return
}