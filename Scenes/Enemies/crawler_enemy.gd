extends Enemy


# Get the gravity from the project settings to be synced with RigidBody nodes.
var facing_right = true

@onready var anim = $AnimatedSprite2D

@export var health = 3;

func handle_physics(_delta):
	handle_flip()
	var direction = 1 if facing_right else -1
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = 0
	

func handle_flip():
	var flipped = false
	if $WallCast.is_colliding():
		flipped = true
	if not $Marker2D/FloorCast.is_colliding() and is_on_floor():
		flipped = true
	
	if flipped:
		flip()

func flip():
	facing_right = !facing_right
	if facing_right:
		$AnimationPlayer.play("FlipRight")
	else :
		$AnimationPlayer.play("FlipLeft")
	$AnimationPlayer.advance(0)


func _on_hit_body(body):
	pass # Replace with function body.


func _on_hitbox_area_entered(area):
	if area.is_in_group("sword"):
		health -= 1	
		if(health == 0):
			$".".queue_free()
	pass # Replace with function body.
