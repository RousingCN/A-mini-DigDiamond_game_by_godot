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
	if checkDiamondsCount():
		hide()
		emit_signal("game_start")

# 检查输入的数据是否符合规则
func checkDiamondsCount()-> bool:
	TempData.row=$CenterContainer/VBoxContainer/ButtonCountEnterContainer/Row.value
	TempData.col=$CenterContainer/VBoxContainer/ButtonCountEnterContainer/Col.value
	TempData.diamondCount=$CenterContainer/VBoxContainer/DiamondCountEnterContainer2/DiamondCount.value
	
	if TempData.row * TempData.col< TempData.diamondCount:
		$CenterContainer/VBoxContainer/ErrorTips.text="钻石的数量不能大于格子的数量"
		return false
	else:
		$CenterContainer/VBoxContainer/ErrorTips.text=""
		return true


# 点击游戏开始按钮
func _on_start_pressed():
	gameStart()
	

# 点击退出游戏按钮
func _on_exit_pressed():
	get_tree().quit()


# 点击加载游戏按钮
func _on_load_pressed():
	pass # Replace with function body.


# 修改行数量输入框的值
func _on_row_value_changed(value):
	print(1)
	checkDiamondsCount()


# 修改列数量输入框的值
func _on_col_value_changed(value):
	print(2)
	checkDiamondsCount()


# 修改钻石数量输入框的值
func _on_diamond_count_value_changed(value):
	print(3)
	checkDiamondsCount()
