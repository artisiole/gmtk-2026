extends PointLight2D

# There's no way this works.


func _on_day_manager_daytime():
	energy = 0.0

func _on_day_manager_sunset():
	energy = 0.0

# These top two are mostly to play it safe with resetting it to 0.0.

func _on_day_manager_nighttime():
	energy = 1.9
