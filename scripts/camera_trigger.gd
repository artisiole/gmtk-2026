extends Area2D

@export var camera: Camera2D
@export var destination: Vector2
@export var pots: Node2D
@export var pot_dest: Node2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		camera.global_position = destination
		body.camera_y_pos = destination.y
		
		pots.global_position = pot_dest.global_position
		
		# fix bug with pot plant not moving properly
		for pot in pots.get_children():
			pot.get_node("PlantInteract").position.y = -18
