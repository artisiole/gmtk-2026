extends StaticBody2D

var interacting: bool = false
var current_interactor

func start_interact(interactor):
	interacting = true
	current_interactor = interactor

func end_interact():
	interacting = false

func _process(delta: float) -> void:
	# interact behavior
	if interacting:
		set_collision_layer_value(1, false)
		global_position = current_interactor.global_position
	else:
		set_collision_layer_value(1, true)
