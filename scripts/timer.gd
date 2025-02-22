extends Control

@export var duration = GameManager.timer_hud

@onready var current_duration = duration
@onready var max_progress = size.x

var is_event_fired = false
var on_timeout : bool = false

func _physics_process(delta: float) -> void:
	GameManager.timer_timeout = false
	if (!GameManager.show_timer_hud):
		return
	current_duration -= delta
	size.x = lerpf(0.0, max_progress, current_duration / duration)
	if (size.x == 0.0 && !is_event_fired && GameManager.show_timer_hud):
		is_event_fired = true
		on_timeout = true
		self.queue_free()
	if !GameManager.timer_lock:
		GameManager.show_timer_hud = false
		self.queue_free()

func _on_tree_exiting():
	if on_timeout :
		GameManager.timer_timeout = true
		print('time out')
	GameManager.show_timer_hud = false
	GameManager.timer_lock = false
