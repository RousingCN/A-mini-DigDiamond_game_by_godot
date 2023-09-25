extends TextureRect

signal game_start


func _ready():
	TempData.rowBox=$CenterContainer/VBoxContainer/ButtonCountEnterContainer/Row
	TempData.colBox=$CenterContainer/VBoxContainer/ButtonCountEnterContainer/Col
	TempData.diamondCountBox=$CenterContainer/VBoxContainer/DiamondCountEnterContainer2/DiamondCount
	# 从JSON文件里读取上次游戏的设置
	Data.loadFromJSON()

# 开始游戏前初始化游戏设置
func gameStart():
	TempData.row=$CenterContainer/VBoxContainer/ButtonCountEnterContainer/Row.value
	TempData.col=$CenterContainer/VBoxContainer/ButtonCountEnterContainer/Col.value
	TempData.diamondCount=$CenterContainer/VBoxContainer/DiamondCountEnterContainer2/DiamondCount.value
	hide()
	emit_signal("game_start")

# 点击游戏开始按钮
func _on_start_pressed():
	gameStart()
	

# 点击退出游戏按钮
func _on_exit_pressed():
	get_tree().quit()

# 点击加载游戏按钮
func _on_load_pressed():
	pass # Replace with function body.
