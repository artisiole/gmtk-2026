extends Area2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and has_overlapping_bodies():
		# All interactables should be on layer2
		#print(get_overlapping_bodies())
		
		# Dodgy
		# If just pressed, prioritize seeds
		#if get_overlapping_bodies().size() > 1 and get_overlapping_bodies()[1].is_in_group("seed"):
			#get_overlapping_bodies()[1].start_interact(self)
		#else:
		# Every single interactable should have a function called start_interact and end_interact
		# This is a little dodgy but who cares
		get_overlapping_bodies()[0].start_interact(self)
		
	if not Input.is_action_pressed("interact") and has_overlapping_bodies(): #Input.is_action_just_released("interact")
		# Every single interactable should have a function called start_interact and end_interact
		# This is a little dodgy but who cares
		
		# When releasing, we should go through every overlapping body and release it
		# This is to prevent buggy behavior with seeds overlapping plots
		for body in get_overlapping_bodies():
			body.end_interact()
	
	if has_overlapping_bodies():
		if get_overlapping_bodies().size() > 1 and get_overlapping_bodies()[0].is_in_group("seed"):
			# This kinda really sucks
			# If you're holding a seed, ignore it and look to body 1
			InteractionTracker.interactable_object = get_overlapping_bodies()[1]
		else:
			InteractionTracker.interactable_object = get_overlapping_bodies()[0]
