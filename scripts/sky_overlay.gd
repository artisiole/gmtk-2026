extends Sprite2D

@onready var sky_overlay: Sprite2D = $"."

# On the "sky_overlay.modulates" :
# These just tween to the next color unless it's the reset, in which case it just SNAPS to white.

func _on_day_manager_daytime():
	sky_overlay.modulate = Color("b3cedb")
	
func _on_day_manager_sunset():
	var modulate_color : Color
	modulate_color.r = 1.02
	modulate_color.g = 0.719
	modulate_color.b = 0.611
	modulate_color.a = 255
	#sky_overlay.modulate = Color(1.02, 0.719, 0.611)
	
	# I don't think you HAVE to set "modulate_color" to mean something per value here, but it's done.
	# Thank you random Reddit problem solvers. :/
	
	var tween = get_tree().create_tween()
	tween.tween_property($".", "modulate", modulate_color, 7.5).set_trans(Tween.TRANS_SINE)
	
	
func _on_day_manager_nighttime():
	var modulate_color : Color
	modulate_color.r = 0.565
	modulate_color.g = 0.555
	modulate_color.b = 1.235
	modulate_color.a = 255
	#sky_overlay.modulate = Color(0.565, 0.555, 1.235)
	
	var tween = get_tree().create_tween()
	tween.tween_property($".", "modulate", modulate_color, 7.5).set_trans(Tween.TRANS_SINE)
	
