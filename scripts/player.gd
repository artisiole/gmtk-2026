extends Sprite2D

# Extremely rudimentary top down movement script
# Will be replaced

var SPEED = 400

func _process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down").normalized()
	
	global_position.x += input.x * delta * SPEED
	global_position.y += input.y * delta * SPEED
	
	if Input.is_action_pressed("sprint"):
		SPEED = 700
	else:
		SPEED = 400
