extends Area2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and has_overlapping_bodies():
		# All interactables should be on layer2
		print(get_overlapping_bodies()[0].name)
		
		# Every single interactable should have a function called start_interact and end_interact
		# This is a little dodgy but who cares
		get_overlapping_bodies()[0].start_interact(self)
		
	if Input.is_action_just_released("interact") and has_overlapping_bodies():
		# Every single interactable should have a function called start_interact and end_interact
		# This is a little dodgy but who cares
		get_overlapping_bodies()[0].end_interact()
