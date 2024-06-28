extends HSlider

@export
var busName: String

var busIndex: int

func _ready():
	busIndex = AudioServer.get_bus_index("Master")
	value_changed.connect(on_value_changed)
	
	value = db_to_linear(AudioServer.get_bus_volume_db(busIndex))
	
func on_value_changed(value: float):
	AudioServer.set_bus_volume_db(
		busIndex, linear_to_db(value)
	)

func _process(delta):
	pass
