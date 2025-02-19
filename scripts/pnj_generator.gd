extends Node2D

@export var number_pnj: int = 10

@export var top_left_limit: Vector2
@export var bot_right_limit: Vector2

func _ready() -> void:
	for i in range(number_pnj):
		var pnj = load("res://scenes/characters/pnj.tscn").instantiate() as RigidBody2D
		pnj.global_position = Vector2(randf_range(top_left_limit.x, bot_right_limit.x), randf_range(bot_right_limit.y, top_left_limit.y))
		add_child(pnj)
