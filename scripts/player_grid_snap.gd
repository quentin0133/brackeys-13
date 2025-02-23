extends CharacterBody2D

var grid_positions = [Vector2(0,0), Vector2(1,0), Vector2(2,0),
					  Vector2(0,1), Vector2(1,1), Vector2(2,1),
					  Vector2(0,2), Vector2(1,2), Vector2(2,2)]
var current_index = 4 # Centre
var HP := 3

signal win
signal lose

func _ready():
	GameManager.timer_hud = 15
	GameManager.show_timer_hud = true
	global_position = grid_positions[4] * 100
	
func _process(_delta):
	if GameManager.timer_timeout :
		win.emit()

func _input(event):
	if event.is_action_pressed("Left") and current_index % 3 > 0:
		current_index -= 1
	elif event.is_action_pressed("Right") and current_index % 3 < 2:
		current_index += 1
	elif event.is_action_pressed("Up") and current_index > 2:
		current_index -= 3
	elif event.is_action_pressed("Down") and current_index < 6:
		current_index += 3

	global_position = grid_positions[current_index] * 100

func takeDmg():
	HP -= 1
	if HP <= 0:
		$"../Health".visible = false
		AudioManager.defeat_sound.play()
		lose.emit()
	$"../FlashDmg".visible = true
	$"../FlashDmg".modulate.a = 1.0
	$"../Health".hframes += 1
	AudioManager.hit.play()
	var tween = create_tween()
	tween.tween_property($"../FlashDmg", "modulate:a", 0.0, 0.5)
	await tween.finished
	$"../FlashDmg".visible = false
