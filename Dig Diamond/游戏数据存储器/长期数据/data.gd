# 上一次游戏的数据
extends Node

const VERSION:String="1.0.0"
var lastSaveTime:int

# 游戏设置
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


# 读取保存JSON文件地址
var filePath:String="res://游戏数据存储器/长期数据/data.json"

func saveTempData():
	row=TempData.row
	col=TempData.col
	diamondCount=TempData.diamondCount
	buttonTypeArray=TempData.buttonTypeArray
	diamondButtonIdArray=TempData.diamondButtonIdArray
	notFoundDiamondCount=TempData.notFoundDiamondCount
	notDigDiamondTimes=TempData.notDigDiamondTimes
	button_count=TempData.button_count
	buttonStateArray=TempData.buttonStateArray
	startTime=TempData.startTime
	playTime=TempData.playTime


# 从json文件加载数据
func loadFromJSON():
	if !FileAccess.file_exists(filePath):
		createJSON()
	var file:FileAccess=FileAccess.open(filePath,FileAccess.READ)
	if file==null:
		print("数据读取出错：",FileAccess.get_open_error())
		return
#	print(file.get_as_text())
	var jsonData=JSON.parse_string(file.get_as_text())
	file.close()
#	print(jsonData)
	if jsonData==null:
		createJSON()
		return
#	print(jsonData.lastSaveTime)
	TempData.rowBox.value=jsonData.data.row
	TempData.colBox.value=jsonData.data.col
	TempData.diamondCountBox.value=jsonData.data.diamondCount
	
# 保存数据到JSON文件
func saveToJSON():
	var file=FileAccess.open(filePath,FileAccess.WRITE)
	lastSaveTime=Time.get_unix_time_from_datetime_dict(Time.get_datetime_dict_from_system())
	var initJsonData:String="{
	\"lastSaveTime\":" + String.num(lastSaveTime) + ",
	\"Version\":\"" + VERSION + "\",
	\"data\":{
		\"row\":" + String.num(row) + ",
		\"col\":" + String.num(col) + ",
		\"diamondCount\":" + String.num(diamondCount) + ",
		\"buttonTypeArray\":[],
		\"diamondButtonIdArray\":[],
		\"notFoundDiamondCount\":" + String.num(notFoundDiamondCount) + ",
		\"notDigDiamondTimes\":" + String.num(notDigDiamondTimes) + ",
		\"button_count\":" + String.num(button_count) + ",
		\"buttonStateArray\":[],
		\"startTime\":" + String.num(startTime) + ",
		\"playTime\":\"\"
	}}"
	file.store_string(initJsonData)
	file.close()

# 初始化游戏创建JSON文件
func createJSON():
	saveToJSON()
