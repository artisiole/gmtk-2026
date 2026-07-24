extends Button

@export var camera: Camera2D
@export var destination: Vector2

var results: bool = false

signal shoptime

func _on_button_up():
	if results == true:
		shoptime.emit()
		
		var tween = get_tree().create_tween()
		tween.tween_property($"../../Camera2D", "global_position", Vector2(640.0, -1080.0), 2.5).set_trans(Tween.TRANS_BACK)
		
		results = false


func _on_day_manager_results():
	results = true
