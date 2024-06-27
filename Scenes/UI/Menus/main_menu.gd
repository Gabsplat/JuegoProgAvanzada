extends Control

signal play_pressed
signal level_select_pressed

func _ready():
	$StartButton.grab_focus()

func _on_play_pressed():
	play_pressed.emit()

func _on_level_select_pressed():
	level_select_pressed.emit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/test_level.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Menus/options.tscn")

func _on_level_selector_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Menus/level_select.tscn")
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()


