extends Area2D

@export var camera: Camera2D
@export var destination: Vector2

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		camera.global_position = destination
		body.camera_y_pos = destination.y
