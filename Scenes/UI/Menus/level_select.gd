extends Control

func _ready():
	$lv1Button.grab_focus()
	
func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Menus/main_menu.tscn")
	
func _on_lv_1_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")

func _on_lv_2_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/test_level_2.tscn")
	
func _on_lv_3_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_3.tscn")
	
func _on_lv_4_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")
