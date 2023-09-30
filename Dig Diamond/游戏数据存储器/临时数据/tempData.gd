extends Node

# 本次游戏的数据
var row:float=1.0
var col:float=1.0
var diamondCount:float=1.0
var buttonTypeArray:Array=[]
var diamondButtonIdArray:Array=[]
var notFoundDiamondCount:int=1
var notDigDiamondTimes:int=0
var button_count:int=1
var buttonStateArray:Array=[]
var startTime:int=0
var playTime:String=""

# 组件引用
var main:Node
var gameStart:TextureRect
var gameOver:TextureRect
var gamePanel:Control
var notFoundDiamondCountShow:Label
var rowBox:SpinBox
var colBox:SpinBox
var diamondCountBox:SpinBox
var buttonCountLabel:Label
var diamondCountLabel:Label
var costTimeLabel:Label
var invalidExcavationTimesLabel:Label


# 初始化游戏数据
func initDiamondArray():
	clearTempData()
	button_count=row*col
	# 随机生成钻石所在的格子id数组
	while (diamondButtonIdArray.size()<diamondCount):
		var randomNum=randi() % button_count
		# 判断该数字是否不曾出现过
		if diamondButtonIdArray.find(randomNum)==-1:
			# 添加新的格子id到钻石数组
			diamondButtonIdArray.append(randomNum)
	# 初始化未发掘的钻石数量
	notFoundDiamondCount=diamondCount
	
	
# 清理上次游戏的数据
func clearTempData():
	buttonTypeArray=[]
	diamondButtonIdArray=[]
	notFoundDiamondCount=1
	notDigDiamondTimes=0
	button_count=1
	buttonStateArray=[]
	startTime=0
	playTime=""
