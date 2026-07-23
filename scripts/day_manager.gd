extends Node2D

@export var camera: Camera2D
@export var destination: Vector2

var time_remaining: float = 7.0
var timing: bool = true

signal timeout

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
	
	
	if time_remaining < 0 and timing == true:
		timeout.emit()
		var tween = get_tree().create_tween()
		tween.tween_property($"..", "global_position", Vector2(640.0, -360.0), 2.5).set_trans(Tween.TRANS_SPRING)
		timing = false
	# Because we're setting timing to be false here, this statement can only be true for one frame.
	# So (hopefully smartly and safely) it's called for until it's true and then STOPS.
	# Therefore, only on the frame [singular] that this is true does it call for the camera motion and send a signal.
	
	if timing == false:
		timerlabel.text = " "
		# Once timing becomes false I'm making the timer invisible
		# We can make it say whatever, but I'm getting a weird bug where it's -0.01 so I'm NOT dealing with that lol

#func dayend() -> void:
	#if timing == false:
		#print("time_remaining")
