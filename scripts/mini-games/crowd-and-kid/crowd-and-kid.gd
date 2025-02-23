extends Node

@export var winning_picture: Texture2D
@export var loosing_picture: Texture2D

@onready var animation: AnimationPlayer = $CanvasLayer/Control/Journal/AnimationPlayer
@onready var image: TextureRect = $CanvasLayer/Control/Journal
@onready var kid: RigidBody2D = $Kid
@onready var kidAnimation: AnimatedSprite2D = $Kid/AnimatedSprite2D
@onready var indication_text = $CanvasLayer/IndicationText

var is_game_win = false
var is_game_loose = false
var end_game = false

var timer_on = false
var time = 0

func _ready():
	AudioManager.defeat_music.stop()
	timer_on = true
	AudioManager.crowd_music.play()
	
func _process(delta):
	if(timer_on):
		time += delta
	var mils = fmod(time,1)*1000
	var secs = fmod(time,60)
	GameManager.data_game["scene_crowd_kid"][6] = "%02d:%03d" % [secs,mils]
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and end_game && GameManager.story_mode:
			if is_game_win: 
				GameManager.next_scene_to_call = "scene_cinematic2win"
			else:
				GameManager.next_scene_to_call = "scene_journalope"
			queue_free()
		if event.pressed and end_game && !GameManager.story_mode:
			GameManager.next_scene_to_call = "chapter_menu"
			queue_free()
			
func _on_shit_body_entered(body: Node2D) -> void:
	if (is_game_win || is_game_loose):
		return
	if (body.name == "Kid"):
		AudioManager.crowd_music.stop()
		AudioManager.defeat_music.play()
		timer_on = false
		$ShitSound.play()
		kidAnimation.stop()
		kid.constant_force.x = 0
		kid.linear_velocity.x = 0
		is_game_loose = true
		animation.play("fade_journal")
		image.texture = loosing_picture
		indication_text.visible = false
		kidAnimation.global_rotation_degrees = 90

func _on_kid_body_entered(body: Node) -> void:
	if (is_game_loose || is_game_win):
		return
	if (body.name == "Player"):
		AudioManager.crowd_music.stop()
		timer_on = false
		AudioManager.hit.play()
		is_game_win = true
		animation.play("fade_journal")
		image.texture = winning_picture
		kid.constant_force.x = -200
		kid.constant_force.y = 25
		kid.constant_torque = 360
		indication_text.visible = false

func _on_animation_player_animation_finished(_anim_name):
	end_game = true
