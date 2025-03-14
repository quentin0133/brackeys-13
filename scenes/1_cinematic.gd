extends Sprite2D

@export var cinematics: Array[Texture2D]
var current_image_index = 0

func _ready():
	if cinematics.size() > 0:
		texture = cinematics[current_image_index]
		$"1cinematic".play()

func _input(event):
	if event.is_action_pressed("Action") or event.is_action_pressed("Attack"):
		current_image_index += 1
		if current_image_index < cinematics.size():
			texture = cinematics[current_image_index]
			match current_image_index:
				1:
					$"1cinematic2".play()
				2:
					$"1cinematic3".play()
				3:
					$"1cinematic4".play()
				4:
					$"1cinematic5".play()
				5:
					$"1cinematic6".play()
				6:
					$"1cinematic7".play()
		else:
			GameManager.next_scene_to_call = "scene_grand_mother"
			queue_free()
	
