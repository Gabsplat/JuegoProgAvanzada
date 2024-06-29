extends Actor
class_name Player

@export var coyote_time_frames = 6;
@export var jump_time_frames = 6;

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera :Camera2D = $Camera2D 

@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25

var health = 3

var jumping = true
var isAttacking = false
var isGettingHurt = false

#Coyote code based on KIDS CAN CODE
var coyote_frames = 30 # How many in-air frames to allow jumping
var coyote = false  # Track whether we're in coyote time or not

signal player_lost_health(new_health)
signal player_lost_all_health

func _ready():
	super()
	%CoyoteTimer.wait_time = coyote_frames / 60.
	%JumpBufferTimer.wait_time = jump_time_frames / 60.
	SceneTrainsition.target = self


func handle_animation(_delta):
	if(Input.is_action_just_pressed("attack")):
		isAttacking = true
		$Attack/CollisionShape2D.disabled = false
		anim.play("attack")
	if not isAttacking and not isGettingHurt:
		if is_on_floor():
			if velocity.x > 5:
				anim.play("walk")
				$Attack.set_scale(Vector2(1, 1))
				anim.flip_h = false
			elif velocity.x < -5:
				anim.play("walk")
				$Attack.set_scale(Vector2(-1, 1))
				anim.flip_h = true
			else:
				anim.play("default")
		else:
			if velocity.y < 0:
				anim.play("jump")
			else:
				anim.play("fall")

func handle_gravity(delta):
	if velocity.y > 0:
		delta *= 1.5
	super(delta)

func handle_physics(_delta):
	if is_on_floor():
		jumping = false
	# Handle Jump.
	
	handle_jump()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

func handle_jump():
	if Input.is_action_just_pressed("jump"):
		%JumpBufferTimer.start()
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.01
	if (not %JumpBufferTimer.is_stopped()) and (is_on_floor() or coyote):
		velocity.y = jump_vel
		%JumpBufferTimer.stop()
		jumping = true
		if coyote:
			coyote = false

func handle_cols():
	super()
	
	if !is_on_floor() and last_floor and not jumping:
		coyote = true
		%CoyoteTimer.start()
	

func take_hit(hitter):
	velocity.x = global_position.direction_to(hitter.global_position).x * jump_vel * 3
	if is_on_floor():
		velocity.y = jump_vel*.5
	anim.play("hurt")
	isGettingHurt = true
	health -= 1
	player_lost_health.emit(health)
	if health <= 0:
		health = 3
		player_lost_all_health.emit()

func set_up_camera_limit(rect:Rect2i):
	rect = rect.abs()
	camera.limit_left = rect.position.x 
	camera.limit_top = rect.position.y
	camera.limit_right = rect.end.x
	camera.limit_bottom = rect.end.y

func _on_coyote_timer_timeout():
	coyote = false
	pass # Replace with function body.

func react_to_hitting(_hitbody):
	anim.play("hurt")
	isGettingHurt = true
	velocity.y = jump_vel
	jumping = true

func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "attack":
		$Attack/CollisionShape2D.disabled = true
		isAttacking = false
	if anim.animation == "hurt":
		isGettingHurt = false

func _on_animated_sprite_2d_animation_changed():
	pass # Replace with function body.
