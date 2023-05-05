Create(tower) {
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
	} Else If (tower = "Handler") {
		Send, {i}							; Beast Handler
	}
	BlockInput Off
	TowerClick(tower)						; Places tower
	If DebugMode
		SendInput, {F12}					; Screenshot
	If (tower = "Hero") {					; Added delay for other heros' higher purchase costs
		If (Hero = "Captain Churchill") {	; $2000
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
		} Else If (Hero = "Geraldo") { 		; $700
			Sleep, 16000
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