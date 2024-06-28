extends Control

@onready var level_selector_scene : PackedScene = preload("res://Scenes/UI/PArts/level_selector.tscn")

signal level_selected(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func add_level(level:LevelResource):
	var selector := level_selector_scene.instantiate()
	selector.level_name = level.level_name
	var signal_emit_callable = emit_level_selected.bind(level)
	selector.button.pressed.connect(signal_emit_callable)

func add_all_levels(level_res:LevelCollectionResource):
	for level in level_res.level_array:
		add_level(level)

func emit_level_selected(level):
	level_selected.emit(level)
	

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Menus/main_menu.tscn")
	
	
func _on_lv_1_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/test_level.tscn")

func _on_lv_2_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/test_level_2.tscn")
	
func _on_lv_3_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_3.tscn")
	
func _on_lv_4_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_4.tscn")
