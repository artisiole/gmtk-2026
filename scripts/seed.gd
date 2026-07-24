extends AnimatableBody2D

var interacting: bool = false
var current_interactor

@export var planted_phase0: Texture2D
@export var planted_phase1: Texture2D
@export var planted_phase2: Texture2D
@export var planted_wilted: Texture2D

@export var phaseTimes = [0.0, 0.0, 0.0]

@export var flower_name: String

func start_interact(interactor):
	interacting = true
	current_interactor = interactor

func end_interact():
	interacting = false
	
	#print("PlotResolver - " + str(get_node("PlotResolver").get_overlapping_areas()))
	
	# This whole snippet is to fix a bug in which the plot does not detect a dropped seed
	var areas = get_node("PlotResolver").get_overlapping_areas()
	
	# Linearly search through each overlapping area when dropping the seed
	# If we find an unfilled plot, great!
	for area in areas:
		if area.is_in_group("plot"):
			if area.planted == false:
				area._on_body_entered(self) # Manually call the on body entered signal
	# This is kinda duct tapey but you gotta do what you gotta do

func _process(delta: float) -> void:
	# interact behavior
	if interacting:
		set_collision_layer_value(3, false)
		global_position = current_interactor.global_position
	else:
		set_collision_layer_value(3, true)
