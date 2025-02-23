extends Sprite2D

@export var sprites: Array[Texture2D]
@onready var collision_shape : CollisionShape2D = $Area2D/CollisionShape2D as CollisionShape2D
@onready var area_2D : ObstacleGrandma = $Area2D

var size_shape : Array[Vector2] = [Vector2(169,344),Vector2(418,81.125),Vector2(421.125,209.375),Vector2(439.563,209.375),Vector2(339.391,234.844),Vector2(202.021,538.422),Vector2(248,393.276),Vector2(200,234.638),Vector2(286,449.319)]
var position_shape : Array[Vector2] = [Vector2(-8.5,5),Vector2(0,0),Vector2(0,0),Vector2(0,0),Vector2(0,0),Vector2(30.011,0),Vector2(0,0),Vector2(0,0),Vector2(0,0)]

var obstacle_number : int = 0
var delay : int = 5

func _ready():
	z_index = obstacle_number
	area_2D.z_index = obstacle_number
	area_2D.obstacle_number = obstacle_number
	texture = sprites[obstacle_number]
	collision_shape.shape.size = size_shape[obstacle_number]
	collision_shape.transform.origin = position_shape[obstacle_number]

func _physics_process(delta):
	if area_2D.is_dragging:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position(), delay * delta)
