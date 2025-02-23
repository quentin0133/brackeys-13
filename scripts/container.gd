class_name SlideContainer extends Area2D

@onready var pointer = $Pointer as Pointer

signal current_position(pos: Vector2)

func _on_area_exited(area: Area2D) -> void:
	if area == pointer :
		reverse()
		
func reverse():
	pointer.direction = -pointer.direction
