extends Node

@onready var gameStart:TextureRect=$gameStart
@onready var gameOver:TextureRect=$gameOver
@onready var gamePanel:Control=$GamePanel

func _ready():
	TempData.main=self
	TempData.gameStart=gameStart
	TempData.gameOver=gameOver
	TempData.gamePanel=gamePanel
	showStartMenu()

# 展示开始界面
func showStartMenu():
	gameStart.visible=true
	gameOver.visible=false
	gamePanel.visible=false

# 展示游戏结束界面
func showOverMenu():
	gameStart.visible=false
	gameOver.visible=true
	gamePanel.visible=false

# 展示游戏面版
func showGamePanel():
	gameStart.visible=false
	gameOver.visible=false
	gamePanel.visible=true
	gamePanel.gameStart()

# 在游戏开始菜单 点击开始游戏
func _on_game_start_game_start():
	Data.saveTempData()
	Data.saveToJSON()
	showGamePanel()

# 在游戏结束界面 点击返回主菜单
func _on_game_over_return_to_menu():
	showStartMenu()

# 游戏结束时 收集本次游戏数据并展示
func _on_game_panel_game_over():
	gameOver.get_child(0).get_child(0).get_child(2).get_child(1).text=String.num(Data.row)+" X "+String.num(Data.col)
	gameOver.get_child(0).get_child(0).get_child(3).get_child(1).text=String.num(Data.diamondCount)
	gameOver.get_child(0).get_child(0).get_child(4).get_child(1).text=Data.playTime
	gameOver.get_child(0).get_child(0).get_child(5).get_child(1).text=String.num(Data.notDigDiamondTimes)+" 次"
	showOverMenu()



