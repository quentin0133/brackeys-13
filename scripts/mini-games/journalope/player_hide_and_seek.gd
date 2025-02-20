class_name PlayerJournalope
extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ground: LoopBackground = $"../Ground"
@onready var generator: ObstacleGeneratorJournalope = $"../ObstaclesGenerator";

var input_enable = true

static var is_hiding = false

func _input(event: InputEvent) -> void:
	if (!input_enable):
		return
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			hide_mode()
		elif event.is_released():
			run_mode()

func hide_mode():
	ground.speed = 0
	animation_player.play("hide")
	is_hiding = true
	generator.pause()

func run_mode():
	ground.speed = 50
	animation_player.play("running")
	#print("Is running")
	is_hiding = false
	generator.resume()
