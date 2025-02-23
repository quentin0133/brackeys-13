extends Sprite2D

@export var cinematics: Array[Texture2D]
var current_image_index = 0

func _ready():
	if cinematics.size() > 0:
		texture = cinematics[current_image_index]
		$"1cinematicWin".play()

func _input(event):
	if event.is_action_pressed("Action") or event.is_action_pressed("Attack"):
		current_image_index += 1
		if current_image_index < cinematics.size():
			texture = cinematics[current_image_index]
			match current_image_index:
				1:
					$"1cinematicWin2".play()
				2:
					$"1cinematicWin3".play()
					self.scale = Vector2(2.413,2.413)

		else:
			queue_free()
	
