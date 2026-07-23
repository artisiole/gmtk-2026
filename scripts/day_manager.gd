extends Node2D

@export var camera: Camera2D
@export var destination: Vector2

var time_remaining: float = 301.0
var timing: bool = true
var day: bool = true
var evening: bool = false
var night: bool = false

signal timeout
signal daytime
signal sunset
signal nighttime

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
	
	# Next few if statements are to send signals so I can trigger time of day effects.
	
	if minutes > 2 and night == true:
		daytime.emit()
		day = true
		night = false
		# a really jank placeholder way for me to send a reset signal to set it back to day
	
	if minutes < 2 and day == true:
		sunset.emit()
		day = false
		evening = true
	
	if minutes < 1 and evening == true:
		nighttime.emit()
		evening = false
		night = true
	
	if time_remaining < 0 and timing == true:
		timeout.emit()
		var tween = get_tree().create_tween()
		tween.tween_property($"..", "global_position", Vector2(640.0, -360.0), 2.5).set_trans(Tween.TRANS_BACK)
		timing = false
	
	# Because we're setting timing to be false here, these statements can only be true for one frame.
	# So (hopefully smartly and safely) it's called for until it's true and then STOPS.
	# Therefore, only on the frame [singular] that this is true does it send a signal.
	# This attaches to SkyOverlay and a script I'd love to run on the lights.
	
	# ^^ ON THE LIGHTS ^^
	# I have ONE light working with the signals. For some reason if they all have the same script it's still only the
	# first one that turns on or off with the signals. Unsure what that is but it's almost 5 and I gotta make sure everything else still works.
	# If you wanna figure it out while I'm sleeping, that'd be huge. "light.gd" exists and is attached to one of the lights. Go ham.
	
	if timing == false:
		timerlabel.text = " "
		# Once timing becomes false I'm making the timer invisible
		# We can make it say whatever, but I'm getting a weird bug where it's -0.01 so I'm NOT dealing with that lol

#func dayend() -> void:
	#if timing == false:
		#print("time_remaining")
