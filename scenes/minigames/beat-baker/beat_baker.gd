extends Node2D

@onready var baker = $Baker as Area2D
@onready var baker_pattern = $"Baker-Patern" as SlideContainer

var end_game : bool = false
var win_flag : bool = false
func _ready() -> void:
	AudioManager.defeat_music.stop()
	AudioManager.baker_music.play()
	baker_pattern.pointer.direction = Vector2.DOWN
	baker_pattern.pointer.velocity = 60

func _input(event):
	if (event.is_action_pressed("Action") or event.is_action_pressed("Attack")) and end_game and win_flag:
		if (GameManager.story_mode):
			GameManager.next_scene_to_call = "scene_cinematic7"
		else:
			GameManager.next_scene_to_call = "chapter_menu"
		queue_free()
	elif (event.is_action_pressed("Action") or event.is_action_pressed("Attack")) and end_game:
		GameManager.next_scene_to_call = "scene_beatbaker"
		queue_free()
		print(GameManager.next_scene_to_call)
	else:
		pass
		

func _on_baker_patern_current_position(pos: Vector2) -> void:
	baker.global_position = pos

func _process(delta: float) -> void:
	
	if is_instance_valid(baker_pattern) and is_safe()  and RandomNumberGenerator.new().randi_range(1,100) > 98 :
		baker_pattern.reverse()
	
func is_safe():
	var y = baker.global_position.y
	return y > -35 && y < 35

func win():
	win_flag=true
	stop()
	$CanvasLayer/Victory.modulate.a = 1
	$CanvasLayer/IndicationText.visible = false
	await get_tree().create_timer(0.6).timeout
	$YES.play()
	await get_tree().create_timer(0.4).timeout
	end_game=true
	
func game_over():
	if !baker.proud : return
	$NO.play()
	AudioManager.defeat_music.play()
	stop()
	$CanvasLayer/GameOver.modulate.a = 1
	$CanvasLayer/IndicationText.visible = false
	await get_tree().create_timer(1.0).timeout
	end_game=true

func stop():
	AudioManager.baker_music.stop()
	$Fighter.playing = false
	baker.proud = false
	if is_instance_valid(baker_pattern):
		baker_pattern.queue_free()


func _on_baker_area_entered(area: Area2D) -> void:
	area.find_child("Slap").stop()
	$Slap.play()
	win()


func _on_fighter_explode() -> void:
	game_over() # Replace with function body.
