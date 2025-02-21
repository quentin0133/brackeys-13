extends CharacterBody2D

var grid_positions = [Vector2(0,0), Vector2(1,0), Vector2(2,0),
					  Vector2(0,1), Vector2(1,1), Vector2(2,1),
					  Vector2(0,2), Vector2(1,2), Vector2(2,2)]
var current_index = 4 # Centre

func _ready():
	global_position = grid_positions[4] * 100

func _input(event):
	if event.is_action_pressed("ui_left") and current_index % 3 > 0:
		current_index -= 1
	elif event.is_action_pressed("ui_right") and current_index % 3 < 2:
		current_index += 1
	elif event.is_action_pressed("ui_up") and current_index > 2:
		current_index -= 3
	elif event.is_action_pressed("ui_down") and current_index < 6:
		current_index += 3

	global_position = grid_positions[current_index] * 100 # Ajuster selon la taille des cases
