extends Button

@export var icon_on_path: String
@export var icon_off_path: String

@onready var icon_on: Texture = preload("res://Assets/UI/LevelUI/Small Text/Small Icons/6.png")
@onready var icon_off: Texture = preload("res://Assets/UI/LevelUI/Small Text/Small Icons/5.png")

var bus_index: int
var is_muted: bool = false

func _ready():
	bus_index = AudioServer.get_bus_index("Master")
	_update_button_icon()
	self.connect("pressed", Callable(self, "_on_music_button_pressed"))

func _on_music_button_pressed():
	if is_muted:
		AudioServer.set_bus_volume_db(bus_index, 0)
		is_muted = false
	else:
		AudioServer.set_bus_volume_db(bus_index, -80)
		is_muted = true
	_update_button_icon()

func _update_button_icon():
	if is_muted:
		self.icon = icon_off
	else:
		self.icon = icon_on
