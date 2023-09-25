extends TextureRect

signal returnToMenu



func _on_return_to_main_pressed():
	emit_signal("returnToMenu")
