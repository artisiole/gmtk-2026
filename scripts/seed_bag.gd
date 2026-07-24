extends StaticBody2D

var interacting: bool = false
var current_interactor

@export var seed_spawned: PackedScene

func start_interact(interactor):
	interacting = true
	current_interactor = interactor
	
	var instance = seed_spawned.instantiate()
	add_child(instance)
	
	var tween = get_tree().create_tween()
	tween.tween_property(instance, "global_transform:origin", Vector2(global_position.x+84, global_position.y) , 0.3).set_trans(Tween.TRANS_QUART)
	tween.tween_property(instance, "scale", Vector2(0.345, 0.438) , 0.3).set_trans(Tween.TRANS_BACK)
	

func end_interact():
	interacting = false
