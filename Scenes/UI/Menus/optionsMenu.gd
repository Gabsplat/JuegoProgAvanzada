extends Control

signal play_pressed
signal level_select_pressed


func _on_play_pressed():
	play_pressed.emit()

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Menus/main_menu.tscn")


func _on_music_button_pressed():
	
	pass # Replace with function body.
