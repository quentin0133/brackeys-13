extends Node2D

@onready var victory_UI: Control = $CanvasLayer/Victory as Control
@onready var lose_UI: Control = $CanvasLayer/Lose as Control

@export var attack_scenes: Array[PackedScene]

var end_game_flag : bool = false
var flag_lose : bool = false

func _ready():
	AudioManager.defeat_music.stop()
	$AttackSpawnerTimer.start()
	AudioManager.monologue_music.play()

func _on_attack_spawner_timer_timeout() -> void:
	if attack_scenes.size() > 0:
		var attack_scene = attack_scenes.pick_random()
		var attack_instance = attack_scene.instantiate()
		add_child(attack_instance)
		$Monologue.play()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and end_game_flag and event.pressed:

		if!GameManager.story_mode :
			GameManager.next_scene_to_call = "main_menu"
			GameManager.update_score("scene_cinematic6")
		elif GameManager.story_mode and flag_lose:
			GameManager.next_scene_to_call = "scene_monologue"
		else:
			GameManager.next_scene_to_call = "main_menu"
		queue_free()


func lose():
	$AttackSpawnerTimer.wait_time = 4096
	AudioManager.defeat_music.play()
	AudioManager.monologue_music.stop()
	GameManager.timer_lock = false
	while (lose_UI.modulate.a < 1):
		await get_tree().create_timer(0.005).timeout
		lose_UI.modulate.a += 0.01
	end_game_flag = true
	flag_lose = true


func win():
	$AttackSpawnerTimer.wait_time = 4096
	AudioManager.monologue_music.stop()
	GameManager.timer_lock = false
	while (victory_UI.modulate.a < 1):
		await get_tree().create_timer(0.005).timeout
		victory_UI.modulate.a += 0.01
	end_game_flag = true
