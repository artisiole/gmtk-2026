extends Node2D

@export var textures: Array[Texture2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.h = randf_range(0.0, 1.0)
	$CustomerSprite.texture = textures[randi_range(0, 4)]
