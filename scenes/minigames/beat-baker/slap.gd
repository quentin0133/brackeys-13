extends Path2D

@onready var follow = $PathFollow2D

func _ready() -> void:
	$PathFollow2D/Area2D/Slap.play()

func _process(delta: float) -> void:
	if follow.progress_ratio < 1:
		follow.progress_ratio += 3*delta
	else :
		queue_free()
