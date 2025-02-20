extends Node

var is_game_win = false
var is_game_loose = false
var end_game = false

@export var winning_picture: Texture2D
@export var loosing_picture: Texture2D

@onready var animation: AnimationPlayer = $CanvasLayer/Control/Journal/AnimationPlayer
@onready var image: TextureRect = $CanvasLayer/Control/Journal
@onready var kid: RigidBody2D = $Kid
@onready var indication_text = $CanvasLayer/IndicationText

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and end_game :
			GameManager.next_scene_to_call = "scene_grand_mother"
			queue_free()
	

func _on_shit_body_entered(body: Node2D) -> void:
	if (is_game_win):
		return
	if (body.name == "Kid"):
		is_game_loose = true
		animation.play("fade_journal")
		image.texture = loosing_picture
		indication_text.visible = false

func _on_kid_body_entered(body: Node) -> void:
	if (is_game_loose):
		return
	if (body.name == "Player"):
		is_game_win = true
		animation.play("fade_journal")
		image.texture = winning_picture
		kid.constant_force.x = -200
		kid.constant_force.y = 25
		kid.constant_torque = 360
		indication_text.visible = false


func _on_animation_player_animation_finished(anim_name):
	end_game = true
