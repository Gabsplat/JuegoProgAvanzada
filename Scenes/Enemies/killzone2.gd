extends Interactable
class_name KillZone

@onready var timer = $Timer
func _on_body_entered(body):
	timer.start()

func _on_timer_timeout():
	#get_tree().reload_current_scene()
	pass
