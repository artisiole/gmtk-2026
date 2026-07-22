extends CharacterBody2D

# Extremely rudimentary top down movement script
# Will be replaced

var SPEED = 400

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down").normalized()
	
	if Input.is_action_pressed("sprint"):
		SPEED = 400
	else:
		SPEED = 300
	
	velocity = input * SPEED
	
	move_and_slide()
