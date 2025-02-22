extends PathFollow2D

@export var speed = 700.0
var can_move = false

func _ready() -> void:
	$"../Warning".visible = true
	await get_tree().create_timer(0.5).timeout
	$"../Warning".queue_free() 
	can_move = true
	

func _process(delta):
	if can_move:
		progress += speed * delta
		if progress_ratio >= 1.0:
			queue_free()
