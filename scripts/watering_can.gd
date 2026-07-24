extends StaticBody2D

var interacting: bool = false
var current_interactor

@export var player: Node2D
@onready var sprite = $WaterCanSprite

func start_interact(interactor):
	interacting = true
	current_interactor = interactor

func end_interact():
	interacting = false

func _process(delta: float) -> void:
	# interact behavior
	if interacting:
		set_collision_layer_value(3, false)
		sprite.flip_h = (global_position.x - player.global_position.x) < 0
		global_position = current_interactor.global_position
	else:
		set_collision_layer_value(3, true)
