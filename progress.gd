extends Marker2D

@onready var fill = $Border/Fill
@export var progressive: bool = true
@export var dangerous: bool = false
@export var reversed: bool = false
var progress = 0.00

signal completed

func _ready() -> void:
	if progressive:
		fill.scale = Vector2(0,1)
	if reversed:
		$Border.rotate(deg_to_rad(180))

func _process(delta):
	if progress < 1 :
		progress += 0.1 * delta
		var scaleX = progress if(progressive) else 1 - progress
		fill.scale = Vector2(scaleX,1)
		if dangerous:
			fill.self_modulate = Color(1,scaleX,0,1)
	else:
		completed.emit()
		queue_free()
