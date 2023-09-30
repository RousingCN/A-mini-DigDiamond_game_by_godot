extends TextureRect

signal returnToMenu



func _ready():
	TempData.buttonCountLabel=$CenterContainer/VBoxContainer/HBoxContainer2/buttonCount
	TempData.diamondCountLabel=$CenterContainer/VBoxContainer/HBoxContainer3/diamonCount
	TempData.costTimeLabel=$CenterContainer/VBoxContainer/CostTimeBox/CostTime
	TempData.invalidExcavationTimesLabel=$CenterContainer/VBoxContainer/InvalidExcavationTimesBox/InvalidExcavationTimes
	

func _on_return_to_main_pressed():
	emit_signal("returnToMenu")
