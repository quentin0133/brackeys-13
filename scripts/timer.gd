extends Control

signal on_timeout

@export var duration = 10

@onready var current_duration = duration
@onready var max_progress = size.x

var is_event_fired = false
var is_playing = true

func _physics_process(delta: float) -> void:
	if (!is_playing):
		return
	current_duration -= delta
	size.x = lerpf(0.0, max_progress, current_duration / duration)
	if (size.x == 0.0 && !is_event_fired && is_playing):
		on_timeout.emit()
		is_event_fired = true

func stop():
	is_playing = false
