extends Button

@export var camera: Camera2D
@export var wipe: Sprite2D

@onready var _animation_player = $"../../Camera2D/doctor/AnimationPlayer"

var shopping: bool = false
var notshopping: bool = true

signal doneshopping

func _on_results_next_shoptime():
	if notshopping == true:
		shopping = true
		notshopping = false


func _on_button_up():
	if shopping == true:
		doneshopping.emit()
		
		_animation_player.play("WIPE")
		
		var tween = get_tree().create_tween()
		tween.tween_property($"../../Camera2D", "global_position", Vector2(640.0, 360.0), 2.5).set_trans(Tween.TRANS_BACK)
		
		notshopping = true
		
		shopping = false
