extends Control

enum{
	STONE=0,
	STONE_SELECT=1,
	STONE_MARK=2,
	STONE_MARK_SELECT=3,
	BEDROCK=4,
	DIAMOND=5
}

# 当前格子的状态	0:默认 1：被选中 2：被标记 3：标记被选中 4:被挖开 5:挖出钻石
var buttonState:int=0
var nearDiamondCount:int=0
var id:int=-1
var haveDiamond:bool=false
var x:int=-1
var y:int=-1

@onready var stone:Sprite2D=$Stone
@onready var stone_select:Sprite2D=$Stone_select
@onready var stone_mark:Sprite2D=$Stone_mark
@onready var stone_mark_select:Sprite2D=$Stone_mark_select
@onready var bedrock:Sprite2D=$Bedrock
@onready var diamond:Sprite2D=$Diamond


func initType():
	if id!=-1:
		checkDiamond()
		upadteLocation()
		checkNearDiamondCount()
		updateNearDiamondCountShow()
	else :
		print("游戏内格子id获取失败")
	
# 检查当前格子是否有钻石
func checkDiamond():
	if TempData.diamondButtonIdArray.find(id)!=-1:
		haveDiamond=true

# 设置格子所在的二维坐标
func upadteLocation():
	#print("更新格子坐标")
	x=id/ TempData.col
	y=id-x*TempData.col
	#print("(",x,",",y,")")
	#print(haveDiamond)

# 计算周围3X3空间内（不包含自己）的钻石数量
func checkNearDiamondCount():
	# 当前格子在左上角
	if x==0&&y==0:
		checkRightButton()
		checkDownButton()
		checkRightDownButton()
	# 当前格子在右上角
	elif x==0&&y==TempData.col-1:
		checkLeftButton()
		checkLeftDownButton()
		checkDownButton()
	# 当前格子在左下角
	elif x==TempData.row-1&&y==0:
		checkUpButton()
		checkRightUpButton()
		checkRightButton()
	# 当前格子在右下角
	elif x==TempData.row-1&&y==TempData.col-1:
		checkLeftUpButton()
		checkUpButton()
		checkLeftButton()
	# 当前格子在最上方一排（不包括角落的格子）
	elif x==0:
		checkLeftButton()
		checkRightButton()
		checkLeftDownButton()
		checkDownButton()
		checkRightDownButton()
	# 当前格子在最下方一排（不包括角落的格子）
	elif x==TempData.row-1:
		checkLeftUpButton()
		checkUpButton()
		checkRightUpButton()
		checkLeftButton()
		checkRightButton()
	# 当前格子在最左方一排（不包括角落的格子）
	elif y==0:
		checkUpButton()
		checkRightUpButton()
		checkRightButton()
		checkDownButton()
		checkRightDownButton()
	# 当前格子在最右方一排（不包括角落的格子）
	elif y==TempData.col-1:
		checkLeftUpButton()
		checkUpButton()
		checkLeftButton()
		checkLeftDownButton()
		checkDownButton()
	# 当前格子在中心区域，检查周围8个格子
	else :
		checkLeftUpButton()
		checkUpButton()
		checkRightUpButton()
		checkLeftButton()
		checkRightButton()
		checkLeftDownButton()
		checkDownButton()
		checkRightDownButton()

# 检查左上方的一个格子是否有钻石
func checkLeftUpButton():
	if TempData.diamondButtonIdArray.find(int(id-TempData.col-1))!=-1:
		nearDiamondCount+=1

# 检查上方的一个格子是否有钻石
func checkUpButton():
	if TempData.diamondButtonIdArray.find(int(id-TempData.col))!=-1:
		nearDiamondCount+=1

# 检查右上方的一个格子是否有钻石
func checkRightUpButton():
	if TempData.diamondButtonIdArray.find(int(id-TempData.col+1))!=-1:
		nearDiamondCount+=1

# 检查左方的一个格子是否有钻石
func checkLeftButton():
	if TempData.diamondButtonIdArray.find(int(id-1))!=-1:
		nearDiamondCount+=1

# 检查右方的一个格子是否有钻石
func checkRightButton():
	if TempData.diamondButtonIdArray.find(int(id+1))!=-1:
		nearDiamondCount+=1

# 检查左下方的一个格子是否有钻石
func checkLeftDownButton():
	if TempData.diamondButtonIdArray.find(int(id+TempData.col-1))!=-1:
		nearDiamondCount+=1

# 检查下方的一个格子是否有钻石
func checkDownButton():
	if TempData.diamondButtonIdArray.find(int(id+TempData.col))!=-1:
		nearDiamondCount+=1

# 检查右下方的一个格子是否有钻石
func checkRightDownButton():

	if TempData.diamondButtonIdArray.find(int(id+TempData.col+1))!=-1:
		nearDiamondCount+=1

# 显示周围格子内的钻石数量
func updateNearDiamondCountShow():
	if nearDiamondCount>0:
		$Label.text=String.num(nearDiamondCount)

# 清理当前格子的数据并移除
func removeButton():
	queue_free()


# 点击了当前格子
func _on_button_pressed():
	# 当前是否为标记模式
	var markType=get_parent().get_parent().get_parent().markType
	# 标记模式
	if markType:
		# 点击被选中的石头
		if buttonState==STONE_SELECT:
			# 标记石头
			stone.visible=false
			stone_select.visible=false
			stone_mark.visible=true
			stone_mark_select.visible=false
			bedrock.visible=false
			diamond.visible=false
			buttonState=STONE_MARK
		# 点击被选中的已标记石头
		elif buttonState==STONE_MARK_SELECT:
			# 取消标记
			stone.visible=true
			stone_select.visible=false
			stone_mark.visible=false
			stone_mark_select.visible=false
			bedrock.visible=false
			diamond.visible=false
			buttonState=STONE
	# 挖掘模式
	else :
		# 点击了被标记的石头
		if buttonState==STONE_MARK_SELECT||buttonState==STONE_MARK:
			return
		# 点击了拥有钻石且未被挖掘的石头
		elif haveDiamond&&buttonState!=DIAMOND:
			# 显示钻石
			stone.visible=false
			stone_select.visible=false
			stone_mark.visible=false
			stone_mark_select.visible=false
			bedrock.visible=false
			diamond.visible=true
			buttonState=DIAMOND
			# 未发掘钻石数量减少
			TempData.notFoundDiamondCount-=1
			# 更新游戏界面的钻石数量显示信息
			TempData.notFoundDiamondCountShow.text="还有"+String.num(TempData.notFoundDiamondCount)+"颗钻石"
			# 所有的钻石都被挖掘后
			if TempData.notFoundDiamondCount==0:
				# 调用父节点内的方法结束游戏
				get_parent().get_parent().get_parent().gameOver()
		# 点击没有钻石的石头
		elif !haveDiamond && (buttonState==STONE||buttonState==STONE_SELECT):
			# 显示基岩
			stone.visible=false
			stone_select.visible=false
			stone_mark.visible=false
			stone_mark_select.visible=false
			bedrock.visible=true
			diamond.visible=false
			buttonState=BEDROCK
			# 无效挖掘次数增加
			TempData.notDigDiamondTimes+=1
		

# 鼠标进入按钮范围
func _on_button_mouse_entered():
	# 移入石头格子
	if buttonState==STONE:
		# 当前石头格子切换为被选择模式
		stone.visible=false
		stone_select.visible=true
		stone_mark.visible=false
		stone_mark_select.visible=false
		bedrock.visible=false
		diamond.visible=false
		buttonState=STONE_SELECT
	# 移入被标记格子
	elif buttonState==STONE_MARK:
		# 当前标记格子切换为被选择模式
		stone.visible=false
		stone_select.visible=false
		stone_mark.visible=false
		stone_mark_select.visible=true
		bedrock.visible=false
		diamond.visible=false
		buttonState=STONE_MARK_SELECT

# 鼠标移出当前格子范围
func _on_button_mouse_exited():
	# 移出被选择的石头格子
	if buttonState==STONE_SELECT:
		# 恢复为未被选择的石头格子状态
		stone.visible=true
		stone_select.visible=false
		stone_mark.visible=false
		stone_mark_select.visible=false
		bedrock.visible=false
		diamond.visible=false
		buttonState=STONE
	# 移出被选择的标记格子
	elif buttonState==STONE_MARK_SELECT:
		# 恢复为未被选择的标记格子状态
		stone.visible=false
		stone_select.visible=false
		stone_mark.visible=true
		stone_mark_select.visible=false
		bedrock.visible=false
		diamond.visible=false
		buttonState=STONE_MARK


func _on_button_button_down():
	_on_button_mouse_entered()


func _on_button_button_up():
	_on_button_mouse_exited()
