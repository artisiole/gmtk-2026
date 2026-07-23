extends Area2D

var planted: bool = false
var plantable: bool = false
var plantTime: float = 0.0

var phase_textures = [ null, null, null, null]
var phase_times =  [0.0, 0.0, 0.0]

var plant_plucked: bool = false

@onready var plant_sprite = get_node("PlantInteract/PlantSprite")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("seed") and not planted and plantable:
		planted = true
		plantTime = 0.0 
		
		# This is bad but literally who cares
		phase_textures[0] = body.planted_phase0
		phase_textures[1] = body.planted_phase1
		phase_textures[2] = body.planted_phase2
		phase_textures[3] = body.planted_wilted
		
		phase_times[0] = body.phaseTimes[0]
		phase_times[1] = body.phaseTimes[1]
		phase_times[2] = body.phaseTimes[2]
		
		plant_sprite.texture = phase_textures[0]
		
		body.queue_free()
		
func _process(delta: float) -> void:
	if planted and not plant_plucked:
		plantTime += delta
		
	if plantTime > phase_times[0]:
		plant_sprite.texture = phase_textures[1]
	if plantTime > phase_times[1]:
		plant_sprite.texture = phase_textures[2]
	if plantTime > phase_times[2]:
		plant_sprite.texture = phase_textures[3]
	
	if InteractionTracker.interactable_object == get_node("PlantInteract") and has_overlapping_areas():
		plantable = true
		get_node("PlotSprite").modulate.a = 0.1
	else: 
		plantable = false
		get_node("PlotSprite").modulate.a = 0
