extends Node

const END_VALUE = 1

var is_active = false
var time_start
var duration_ms
var start_value

func start(duration = 0.4, strength = 0.9):
	time_start = OS.get_ticks_msec()
	duration_ms = duration * 1000
	start_value = 1 - strength
	Engine.time_scale = start_value
	is_active = true
	
func _ready():
	Engine.time_scale = 1
	
func _process(delta):
	if is_active:
		var current_time = OS.get_ticks_msec() - time_start
		var circl_value = circl_ease_in(current_time, start_value, END_VALUE, duration_ms)
		if current_time >= duration_ms:
			is_active = false
			circl_value = END_VALUE
		Engine.time_scale = circl_value
		
func circl_ease_in(current_time, start_value, end_value, duration):
	current_time /= duration
	return - end_value * (sqrt(1 - current_time * current_time) - 1) + start_value
