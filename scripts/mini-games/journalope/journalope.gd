class_name Journalope
extends Node2D

@export var distance_parcoured_winning = 4000
@export var range_journalist_show_up = Vector2(3.0, 8.0)
@export var player_flashed: Texture2D

@onready var animation_player_gameover = $CanvasLayer/GameOver/Journalist/AnimationPlayer
@onready var ground = $Ground
@onready var timer = $CanvasLayer/Timer
@onready var player: PlayerJournalope = $Player
@onready var animation_player_player = $Player/AnimationPlayer
@onready var generator: ObstacleGeneratorJournalope = $ObstaclesGenerator
@onready var indication: Label = $CanvasLayer/IndicationText
@onready var victory_UI: Control = $CanvasLayer/Victory

var is_game_win = false
var is_game_loose = false
var end_game_flag = false

static var isJournalistShowed = false

func _ready():
	AudioManager.defeat_music.stop()
	AudioManager.journalope_music.play()
	if !GameManager.story_mode:
		timer.visible = false


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and end_game_flag and GameManager.story_mode and is_game_win :
			GameManager.next_scene_to_call = "scene_cinematic3"
			queue_free()
		elif event.pressed and end_game_flag and !GameManager.story_mode  :
			GameManager.next_scene_to_call = "chapter_menu"
			GameManager.update_score("scene_journalope")
			queue_free()
		elif is_game_loose and end_game_flag and GameManager.story_mode:
			is_game_loose =false
			queue_free()

func _on_timer_on_timeout() -> void:
	if GameManager.story_mode :
		game_over()

func _process(delta: float) -> void:
	if (is_game_win || is_game_loose):
		return
	elif (abs(ground.global_position.x) > distance_parcoured_winning && !is_game_win && !is_game_loose && GameManager.story_mode):
		win()
	elif (isJournalistShowed && !player.is_hiding):
		game_over()

	
func win():
	AudioManager.defeat_music.stop()
	AudioManager.journalope_music.stop()
	is_game_win = true
	#print("Win")
	timer.stop()
	generator.is_generating = false
	animation_player_player.play("winning")
	player.input_enable = false
	await get_tree().create_timer(1.9).timeout
	$Poteau.play()
	while (victory_UI.modulate.a < 1):
		await get_tree().create_timer(0.005).timeout
		victory_UI.modulate.a += 0.01
	end_game_flag = true
	
func game_over():
	AudioManager.defeat_music.play()
	AudioManager.journalope_music.stop()
	if (is_game_win):
		return
	animation_player_gameover.play("gameover")
	is_game_loose = true
	ground.speed = 0
	generator.is_generating = false
	animation_player_player.pause()
	player.texture = player_flashed;
	player.input_enable = false
	$MortParFlash.play()
	$RunningSounds.stop()


func _on_timer_timeout() -> void:
	while (indication.modulate.a > 0):
		await get_tree().create_timer(0.005).timeout
		indication.modulate.a -= 0.01


func _on_animation_player_animation_finished(anim_name):
	end_game_flag = true
