extends Area2D

var planted: bool = false
var plantTime: float = 0.0

var phase_textures = [ null, null, null, null]
var phase: int = 0
var phase_times =  [0.0, 0.0, 0.0]

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.is_in_group("seed"):
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
		
		get_node("PlantSprite").texture = phase_textures[0]
		
		body.queue_free()
		
func _process(delta: float) -> void:
	if planted:
		plantTime += delta
		
	if plantTime > phase_times[0]:
		get_node("PlantSprite").texture = phase_textures[1]
	if plantTime > phase_times[1]:
		get_node("PlantSprite").texture = phase_textures[2]
	if plantTime > phase_times[2]:
		get_node("PlantSprite").texture = phase_textures[3]
