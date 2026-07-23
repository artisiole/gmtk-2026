extends AnimatableBody2D

var interacting: bool = false
var current_interactor

@export var planted_phase0: Texture2D
@export var planted_phase1: Texture2D
@export var planted_phase2: Texture2D
@export var planted_wilted: Texture2D

@export var phaseTimes = [0.0, 0.0, 0.0]

func start_interact(interactor):
	interacting = true
	current_interactor = interactor

func end_interact():
	interacting = false

func _process(delta: float) -> void:
	# interact behavior
	if interacting:
		set_collision_layer_value(3, false)
		global_position = current_interactor.global_position
	else:
		set_collision_layer_value(3, true)
