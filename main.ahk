#NoEnv
#SingleInstance, Force
; #WinActivateForce
; AutoTrim, On

SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1
SetTitleMatchMode, 3

SendMode, Event
SetKeyDelay, 65, 65
SetMouseDelay, 65
SetWinDelay, 65
CoordMode, Mouse, Client
CoordMode, Pixel, Client

UpdateDate = 2023-05-05
BloonsVersion = 36.3.6489

global OrderedMaps = ["Monkey Meadow","Tree Stump","Town Center","Middle Of The Road","One Two Tree","Scrapyard","The Cabin","Resort","Skates","Lotus Island","Candy Falls","Winter Park","Carved","Park Path","Alpine Run","Frozen Over","In The Loop","Cubism","Four Circles","Hedge","End Of The Road","Logs","","","Polyphemus","Covered Garden","Quarry","Quiet Street","Bloonarius Prime","Balance","Encrypted","Bazaar","Adora's Temple","Spring Spring","KartsNDarts","Moon Landing","Haunted","Downstream","Firing Range","Cracked","Streambed","Chutes","Rake","Spice Islands","","","","","Midnight Mansion","Sunken Columns","X Factor","Mesa","Geared","Spillway","Cargo","Pat's Pond","Peninsula","High Finance","Another Brick","Off The Coast","Cornfield","Underground","","","","","Dark Dungeons","Sanctuary","Ravine","Flooded Valley","Infernal","Bloddy Puddles","Workshop","Quad","Dark Castle","Muddy Puddles","#Ouch",""]
global OrderedHeros = ["Quincy","Gwendolin","Striker Jones","Obyn Greenfoot","Geraldo","Captain Churchill","Benjamin","Ezili","Pat Fusty","Adora","Admiral Brickell","Etienne","Sauda","Psi",""]

global Map,Difficulty,Hero,StartOn,EndOn,DebugMode,CashMode,CustomScript,LoopAmount,Storefront,Resolution,ClientWidth,ClientHeight,nextX,nextY
global DartX,DartY,BoomerangX,BoomerangY,BombX,BombY,TackX,TackY,IceX,IceY,GlueX,GlueY,SniperX,SniperY,SubX,SubY,BuccaneerX,BuccaneerY,AceX,AceY,HeliX,HeliY,MortarX,MortarY,DartlingX,DartlingY,WizardX,WizardY,SuperX,SuperY,NinjaX,NinjaY,Ninja2X,Ninja2Y,AlchemistX,AlchemistY,DruidX,DruidY,FarmX,FarmY,EngineerX,EngineerY,SpikeX,SpikeY,VillageX,VillageY,HeroX,HeroY

DefaultMap := "Dark Castle"
DefaultDifficulty := "Standard (Easy)"
DefaultHero := "Quincy"

BotTray()
BotGUI()
Return

Info:
	Info()
    Return

GuiClose:
	ExitApp

F1::
	Gui, Show, Restore, BotTD6
	Return
F2::
	BotStart()
    Return
F3::
	BotPause()
	Return
F4::
	ExitApp
F5::
	Reload
F6::
	MouseGetPos, OutputVarX, OutputVarY, , , 
	Msgbox, %OutputVarX%, %OutputVarY%
	Return