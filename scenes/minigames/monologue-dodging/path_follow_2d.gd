extends PathFollow2D

@export var speed = 700.0

func _process(delta):
	progress += speed * delta
	if progress_ratio >= 1.0:
		queue_free()
