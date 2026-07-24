extends Area2D

signal customer_served(slot_name)

@onready var plot_sprite = $PlotSprite

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("potted_plant"):
		body.get_parent().planted = false
		body.end_interact()
		body.get_node("PotPlantSprite").texture = null
		customer_served.emit(get_parent().name)

func _process(delta: float) -> void:
	if has_overlapping_areas():
		plot_sprite.modulate.a = 0.3
	else:
		plot_sprite.modulate.a = 0.0
