extends Control

signal game_over

# 点击行为：标记模式
var markType:bool=false

# 游戏面板
@onready var mainPanel:GridContainer=$ScrollContainer/MainPanel

func gameStart():
	# 保存引用，在挖出钻石后修改标签文本
	TempData.notFoundDiamondCountShow=$PanelFooter/NotFoundDiamondCount
	# 随机生成游戏数据
	TempData.initDiamondArray()
	# 设置游戏格子的列数
	mainPanel.columns=TempData.col
	# 添加游戏格子到游戏面板上
	for i in range(TempData.row*TempData.col):
		# 读取格子场景配置文件
		var sce=preload("res://格子/gameButton.tscn").instantiate()
		# 分配格子专属的id
		sce.id=i
		# 初始化格子的属性
		sce.initType()
		# 添加格子到游戏面板上
		mainPanel.add_child(sce)
	# 记录游戏开始时间
	TempData.startTime=Time.get_unix_time_from_datetime_dict(Time.get_datetime_dict_from_system())
	# 保存本次游戏的设置到JSON文件里
	Data.saveToJSON()
	# 设置面板底部的信息显示
	$PanelFooter/ButtonCount.text="  "+String.num(TempData.row)+" X "+String.num(TempData.col)
	TempData.notFoundDiamondCountShow.text="还有"+String.num(TempData.notFoundDiamondCount)+"颗钻石"
	
# 重置游戏
func gameReset():
	clearButton()
	gameStart()

# 清除所有的游戏格子
func clearButton():
	for i in mainPanel.get_child_count():
		var btn=mainPanel.get_child(i)
		btn.removeButton()

# 游戏结束
func gameOver():
	clearButton()
	# 保存本次游戏的结果数据
	Data.saveTempData()
	# 清除本次游戏的数据
	TempData.clearTempData()
	emit_signal("game_over")
	

func _process(delta):
	# 获取当前unix格式时间
	var nowDatetime=Time.get_unix_time_from_datetime_dict(Time.get_datetime_dict_from_system())
	# 减去游戏开始时的时间获得游戏开始时长
	TempData.playTime=Time.get_time_string_from_unix_time(nowDatetime-TempData.startTime)
	# 设置游戏时长
	$PanelFooter/PlayTime.text=TempData.playTime+"  "

# 点击主菜单按钮
func _on_menu_pressed():
	clearButton()
	# 展示开始界面
	TempData.main.showStartMenu()

# 点击重置游戏按钮
func _on_re_set_pressed():
	gameReset()

# 点击挖掘按钮
func _on_dig_type_pressed():
	# 切换点击行为 —> 标记模式
	$PanelHead/DigType.visible=false
	$PanelHead/MarkType.visible=true
	markType=true

# 点击标记按钮
func _on_mark_type_pressed():
	# 切换点击行为 —> 挖掘模式
	$PanelHead/DigType.visible=true
	$PanelHead/MarkType.visible=false
	markType=false
