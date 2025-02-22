class_name Pointer extends Area2D

@export var velocity = 30
@export var direction = Vector2.RIGHT
@export var running = true

func _physics_process(delta: float) -> void:
	if running:
		global_position += direction * (velocity * delta)
		get_parent().current_position.emit(global_position)
