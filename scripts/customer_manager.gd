extends Node2D

@export var slots: Array
var slot_available: Array[bool] = [true, true, true]

@export var customer: PackedScene

@onready var spawn_point = $Outside
@onready var pivot_point_1 = $Inside
@onready var pivot_point_2 = $SidePivot

var number_of_slots: int = 3

var spawn_cooldown: float = 0.0

func spawn_customer() -> void:
	var instance = customer.instantiate()
	
	for slot in range(number_of_slots):
		if slot_available[slot]:
			get_node(slots[slot]).add_child(instance)
			instance.global_position = spawn_point.global_position
			
			var tween = get_tree().create_tween()
			tween.tween_property(instance, "global_position", pivot_point_1.global_position, 2.0)
			
			if slot == 0: # Side pivot
				tween.tween_property(instance, "global_position", pivot_point_2.global_position, 2.0)
			
			tween.tween_property(instance, "position", Vector2.ZERO, 3.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			
			slot_available[slot] = false
			break

func is_slot_available() -> bool:
	for slot in range(number_of_slots):
		if slot_available[slot]:
			return true
	return false

func _process(delta: float) -> void:
	spawn_cooldown -= delta
	
	if spawn_cooldown < 0 and is_slot_available():
		spawn_customer()
		spawn_cooldown = randf_range(5.0, 20.0)
		

func _on_deposit_customer_served(slot_name: Variant) -> void:
	print(get_node(str(slot_name)).get_children())
	get_node(str(slot_name)).get_node("Customer").queue_free()
	
	# substring final character as the index
	#ew
	slot_available[ (int(slot_name.right(1))-1) ] = true
