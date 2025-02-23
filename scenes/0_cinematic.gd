extends Sprite2D

@export var cinematics: Array[Texture2D]
var current_image_index = 0

func _ready():
	if cinematics.size() > 0:
		texture = cinematics[current_image_index]
		$"0cinematic".play()

func _input(event):
	if event.is_action_pressed("Action") or event.is_action_pressed("Attack"):
		current_image_index += 1
		if current_image_index < cinematics.size():
			texture = cinematics[current_image_index]
			match current_image_index:
				1:
					$"0cinematic".stop()
					$"0cinematic2".play()
					$AlarmSounds.play()
				2:
					$AlarmSounds.volume_db += 20
		else:
			GameManager.next_scene_to_call = "scene_wakywaky"
			queue_free()
	
