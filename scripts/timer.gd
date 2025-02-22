extends Control

signal on_timeout

@export var duration = GameManager.timer_hud

@onready var current_duration = duration
@onready var max_progress = size.x

var is_event_fired = false

func _physics_process(delta: float) -> void:
	GameManager.timer_timeout = false
	if (!GameManager.show_timer_hud):
		return
	current_duration -= delta
	size.x = lerpf(0.0, max_progress, current_duration / duration)
	if (size.x == 0.0 && !is_event_fired && GameManager.show_timer_hud):
		on_timeout.emit()
		is_event_fired = true
		self.queue_free()


func _on_tree_exiting():
	GameManager.timer_timeout = true
	GameManager.show_timer_hud = false
	GameManager.timer_lock = false
	print('time out')
