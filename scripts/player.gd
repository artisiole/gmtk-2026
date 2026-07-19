extends Sprite2D

# Extremely rudimentary top down movement script
# Will be replaced

const SPEED = 500

func _process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down").normalized()
	
	global_position.x += input.x * delta * SPEED
	global_position.y += input.y * delta * SPEED
