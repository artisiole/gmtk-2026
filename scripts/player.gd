extends CharacterBody2D

# Extremely rudimentary top down movement script
# Will be replaced

var SPEED = 400

var rotation_pivot

func _ready() -> void: 
	rotation_pivot = get_node("RotationPivot")

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down").normalized()
	
	if Input.is_action_pressed("sprint"):
		SPEED = 400
	else:
		SPEED = 300
	
	velocity = input * SPEED
	
	move_and_slide()

func _process(delta: float) -> void:
	# rotate cursor to be pointing to the mouse
	
	# get the vectors needed
	var v1: Vector2 = Vector2.RIGHT
	var v2: Vector2 = (get_viewport().get_mouse_position() - global_position).normalized()  # The vector between the player position and mouse position
	
	var angle = acos(v1.dot(v2))
	# Multiple the angle by the sign of the y component of v2
	# if the mouse is above the player, v2.y < 0
	angle *= sign(v2.y)
	
	# Lerp smoothing hopefully done right
	var blend = pow(0.5, delta * 500) # magic number
	rotation_pivot.rotation = lerp_angle( rotation_pivot.rotation, angle, blend)
	
	# Set sprite rotation to the opposite of the pivot rotation to keep it unrotated
	rotation_pivot.get_node("Interactor/CursorSprite").rotation = -rotation_pivot.rotation
