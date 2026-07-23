extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("entered")
	if body.is_in_group("plant"):
		# Same as compost, except set a new plant
		
		body.end_interact()
		var plot = body.get_parent()
		get_node("PlantInteract/PotPlantSprite").texture = plot.plant_sprite.texture
		
		plot.planted = false
		plot.plant_plucked = false
		plot.plantTime = 0.0
		plot.plant_sprite.texture = null
		plot.get_node("PlantInteract").position = Vector2.ZERO
