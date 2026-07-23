extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plant"):
		body.end_interact()
		var plot = body.get_parent()
		plot.planted = false
		plot.plant_plucked = false
		plot.plantTime = 0.0
		plot.plant_sprite.texture = null
		plot.get_node("PlantInteract").position = Vector2.ZERO
	if body.is_in_group("potted_plant"):
		body.get_parent().planted = false
		body.end_interact()
		body.get_node("PotPlantSprite").texture = null
