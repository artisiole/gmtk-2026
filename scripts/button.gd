extends TextureButton


func _ready() -> void:
	pass


func _on_button_up():
	get_tree().change_scene_to_file("res://scenes/maine.tscn")
