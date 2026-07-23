extends StaticBody2D

var interacting: bool = false
var current_interactor

@onready var pot = get_parent()

func start_interact(interactor):
	interacting = true
	current_interactor = interactor

func end_interact():
	interacting = false
	position = Vector2(0, -18)

func _process(delta: float) -> void:
	# interact behavior
	if interacting:
		set_collision_layer_value(3, false)
		global_position = current_interactor.global_position
	else:
		set_collision_layer_value(3, true)
