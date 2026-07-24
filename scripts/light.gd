extends Node2D

# There's no way this works.


func _on_day_manager_daytime():
	for light in get_children():
		light.energy = 0.5
		light.color = Color("ffffff84")

func _on_day_manager_sunset():
	for light in get_children():
		var brightness = 1.0
		
		var light_color : Color = Color("84c7f83e")
		
		var tween = get_tree().create_tween()
		tween.tween_property(light, "energy", brightness, 7.5).set_trans(Tween.TRANS_LINEAR)
		
		var tween2 = get_tree().create_tween()
		tween2.tween_property(light, "color", light_color, 7.5).set_trans(Tween.TRANS_LINEAR)

func _on_day_manager_nighttime():
	for light in get_children():
		var brightness = 1.9
		
		var light_color : Color = Color("ffaf723e")
		
		var tween = get_tree().create_tween()
		tween.tween_property(light, "energy", brightness, 7.5).set_trans(Tween.TRANS_LINEAR)
		
		var tween2 = get_tree().create_tween()
		tween2.tween_property(light, "color", light_color, 7.5).set_trans(Tween.TRANS_LINEAR)

func _on_day_manager_timeout():
	for light in get_children():
		light.energy = 0.0
