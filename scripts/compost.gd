extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plant"):
		body.end_interact()
		var plot = body.get_parent()
		plot.planted = false
		plot.plantTime = 0.0
		plot.plant_sprite.texture = null
		plot.get_node("PlantInteract").position = Vector2.ZERO
