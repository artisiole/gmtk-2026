extends CharacterBody2D

# Extremely rudimentary top down movement script
# Will be replaced
# ^^ lmfao fuckin goober we're using this shit

var SPEED = 400
const cursor_max_distance = 129

var rotation_pivot
var interactor

var timeout: bool = false

var camera_y_pos: int = 360

@onready var animated_sprite = $PlayerSprite
@onready var free_head = $PlayerSprite/Doghead
@onready var _animation_player = $AnimationPlayer

func _ready() -> void: 
	rotation_pivot = get_node("RotationPivot")
	interactor = get_node("RotationPivot/Interactor")

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down").normalized()
	
	if timeout == false and input != Vector2.ZERO:
		_animation_player.play("walk")
	else:
		_animation_player.play("RESET")
	
	if Input.is_action_pressed("sprint"):
		SPEED = 400
		_animation_player.speed_scale = 1.5
	else:
		SPEED = 300
		_animation_player.speed_scale = 1
	
	
	if timeout == true:
		velocity = input * 0
	else:
		velocity = input * SPEED
	
	move_and_slide()

func _process(delta: float) -> void:
	# Cursor behavior
	var adjusted_mouse_pos: Vector2
		
	
	if camera_y_pos == 1080:
		adjusted_mouse_pos = Vector2(get_viewport().get_mouse_position().x, get_viewport().get_mouse_position().y + 720)
	else:
		adjusted_mouse_pos = get_viewport().get_mouse_position()
	
	var player_orient = (adjusted_mouse_pos.x - global_position.x)
	
	if timeout == false and player_orient:
		animated_sprite.flip_h = player_orient < 0
		free_head.flip_h = player_orient < 0
	
	if timeout: # If the day is over, just skip the rest of this script
		return
	
	var distance_from_mouse = (adjusted_mouse_pos - global_position).length()
	
	if distance_from_mouse > cursor_max_distance: # if the mouse is farther from the player than the cursor max distance, point it towards the mouse
		# reset interactor position to max distance
		rotation_pivot.get_node("Interactor").position = Vector2(86, 0)
		
		# get the vectors needed
		var v1: Vector2 = Vector2.RIGHT
		var v2 = (adjusted_mouse_pos - global_position).normalized() # The vector between the player position and mouse position
		
		var angle = acos(v1.dot(v2))
		# Multiple the angle by the sign of the y component of v2
		# if the mouse is above the player, v2.y < 0
		angle *= sign(v2.y)
		
		## Lerp smoothing hopefully done right
		#var blend = pow(0.5, delta * 500) # magic number
		#rotation_pivot.rotation = lerp_angle( rotation_pivot.rotation, angle, blend)
		rotation_pivot.rotation = angle
		
		# Set sprite rotation to the opposite of the pivot rotation to keep it unrotated
		interactor.get_node("CursorSprite").rotation = -rotation_pivot.rotation
	else: # otherwise, set the cursor position to the mouse position
		rotation_pivot.rotation = 0
		interactor.get_node("CursorSprite").rotation = 0
		interactor.global_position = adjusted_mouse_pos


func _on_day_manager_timeout():
	timeout = true
	# WE GOT THE SIGNAL BABYYYYYYYYY
	# Just using this to flick a bool that'll allow us to check if you should be ALLOWED to move
