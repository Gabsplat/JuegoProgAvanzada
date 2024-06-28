extends CanvasLayer

@onready var healthContainer = $Control/HBoxContainer2
@onready var scoreContainer = $Control/HBoxContainer/ScoreContainer
@onready var timeContainer = $Control/HBoxContainer/TimeContainer
@onready var heartBar = $HeartBar


@onready var hearts = healthContainer.get_children()

@onready var current_heart_index = len(hearts)-1
@onready var deathBar = preload("res://NewResources/Wood and Paper UI/Sprites/Life Bars/Big Bars/2.png")
@onready var full_heart_tex = preload("res://NewResources/Wood and Paper UI/Sprites/Life Bars/Colors/1.png")
@onready var empty_heart_tex = preload("res://Assets/UI/hud_heartEmpty.png")
func _ready():
	pass # Replace with function body.
	
func full_health():
	current_heart_index = len(hearts)-1
	for i in range(3):
		hearts[i].texture = full_heart_tex

func gain_health():
	current_heart_index = min(len(hearts)-1, current_heart_index+1)
	hearts[current_heart_index].texture = full_heart_tex

func lose_health():
	hearts[current_heart_index].modulate = Color(1, 1, 1, 0.25)
	current_heart_index = max(0, current_heart_index-1)
	if current_heart_index == 0:
		heartBar.texture = deathBar

func update_score(new_score):
	scoreContainer.get_node("Label2").text = str(new_score)

func update_time(new_time):
	timeContainer.get_node("Label2").text = String.num(new_time, 2).pad_decimals(2)
