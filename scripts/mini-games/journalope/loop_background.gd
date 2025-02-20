class_name LoopBackground
extends Node2D

@export var speed: float
@export var grounds: Array[Node2D]

var last_background
var current_background = 0

func _ready() -> void:
	last_background = grounds.size() - 1
"res://scripts/AnimatedTextureRect.gd"
func _physics_process(delta: float) -> void:
	global_position.x -= delta * speed
	if (grounds[current_background].global_position.x <= -130):
		grounds[current_background].global_position.x = grounds[last_background].global_position.x + 66
		last_background = current_background
		current_background += 1
		if (current_background == grounds.size()):
			current_background = 0
