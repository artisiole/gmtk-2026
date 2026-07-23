extends StaticBody2D

var interacting: bool = false
var current_interactor

@onready var plot = get_parent()

func start_interact(interactor):
	if plot.planted:
		interacting = true
		current_interactor = interactor
		plot.plant_plucked = true

func end_interact():
	if plot.planted:
		interacting = false
		if abs( global_position - plot.global_position ).length() < 70: # if the plant is close to the plot, teleport it to the plot and resume growth
			plot.plant_plucked = false
			global_position = plot.global_position

func _process(delta: float) -> void:
	# interact behavior
	if interacting:
		global_position = current_interactor.global_position
