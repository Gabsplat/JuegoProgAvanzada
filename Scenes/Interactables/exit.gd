extends Interactable
class_name Exit


const FILE_BEGIN = "res://Scenes/Levels/level_"
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		call_deferred("changeLevel")
		
		
func changeLevel():
	var current_scene_file = get_tree().current_scene.scene_file_path
	print(current_scene_file)
	var next_level_number = current_scene_file.to_int() + 1
	print(next_level_number)
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	print(next_level_path)
	get_tree().change_scene_to_file(next_level_path)
