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

static var isJournalistShowed = false

func _on_timer_on_timeout() -> void:
	game_over()

func _process(delta: float) -> void:
	if (is_game_win || is_game_loose):
		return
	if (abs(ground.global_position.x) > distance_parcoured_winning && !is_game_win && !is_game_loose):
		win()
	if (isJournalistShowed && !player.is_hiding):
		game_over()

func win():
	is_game_win = true
	#print("Win")
	timer.stop()
	generator.is_generating = false
	animation_player_player.play("winning")
	player.input_enable = false
	await get_tree().create_timer(2.35).timeout
	while (victory_UI.modulate.a < 1):
		await get_tree().create_timer(0.005).timeout
		victory_UI.modulate.a += 0.01

func game_over():
	if (is_game_win):
		return
	animation_player_gameover.play("gameover")
	is_game_loose = true
	ground.speed = 0
	generator.is_generating = false
	animation_player_player.pause()
	player.texture = player_flashed;


func _on_timer_timeout() -> void:
	while (indication.modulate.a > 0):
		await get_tree().create_timer(0.005).timeout
		indication.modulate.a -= 0.01
