extends Node2D

var time_remaining: float = 300.0
var timing: bool = true

@onready var timerlabel = $Control/TimerLabel

func _process(delta: float) -> void:
	if timing:
		time_remaining -= delta
	
	var minutes = int(time_remaining / 60)
	var seconds = fmod(time_remaining, 60.0)
	
	if minutes < 1:
		timerlabel.text = " " + str("%0.2f" % seconds)
	elif seconds < 10:
		timerlabel.text = " " + str(minutes) + ":0" + str(int(seconds))
	else:
		timerlabel.text = " " + str(minutes) + ":" + str(int(seconds))
	
	if time_remaining < 0:
		timing = false
