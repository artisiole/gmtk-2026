extends Area2D

var planted: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plant") and not planted:
		# Same as compost, except set a new plant
		planted = true
		body.planted = true
		
		body.end_interact()
		var plot = body.get_parent()
		get_node("PlantInteract/PotPlantSprite").texture = plot.plant_sprite.texture
		get_node("PlantInteract").flower_name = plot.plant_name
		
		#print(InteractionTracker.interactable_object)
		##print(get_node("PlantInteract").flower_name)
		
		plot.planted = false
		plot.plant_plucked = false
		plot.plantTime = 0.0
		plot.plant_sprite.texture = null
		plot.get_node("PlantInteract").position = Vector2.ZERO
		
		if get_node("PlantInteract/PotPlantSprite").texture == null:
			planted = false
