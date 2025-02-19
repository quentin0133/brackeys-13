extends RigidBody2D

@export var heads: Array[Texture2D]
@export var bodies: Array[Texture2D]

@export var top_left_limit: Vector2
@export var bot_right_limit: Vector2

@onready var headSpriteContainer: Sprite2D = $Head
@onready var bodySpriteContainer: Sprite2D = $Body

const MIN_SPEED = 3400
const MAX_SPEED = 6500
const MIN_DIST = 10
const MAX_DIST = 20
const DISTANCE_REACH_TARGET = 8

var speed = randi_range(MIN_SPEED, MAX_SPEED)
var target

func _ready() -> void:
	headSpriteContainer.texture = heads[randi_range(0, heads.size() - 1)]
	bodySpriteContainer.texture = bodies[randi_range(0, bodies.size() - 1)]
	get_new_target()

func _physics_process(delta: float) -> void:
	if (global_position.distance_to(target) < DISTANCE_REACH_TARGET):
		get_new_target()
	
	var direction = global_position.direction_to(target)
	linear_velocity = speed * delta * direction
	headSpriteContainer.flip_h = direction.x > 0
	bodySpriteContainer.flip_h = direction.x > 0

func get_new_target():
	while (target == null || global_position.distance_to(target) < DISTANCE_REACH_TARGET):
		var x_negative = -1 if randi_range(0, 1) == 0 else 1
		var y_negative = -1 if randi_range(0, 1) == 0 else 1
		target = global_position + Vector2(randf_range(MIN_DIST, MAX_DIST) * x_negative, randf_range(MIN_DIST, MAX_DIST) * y_negative)
		target.x = clamp(target.x, top_left_limit.x, bot_right_limit.x)
		target.y = clamp(target.y, top_left_limit.y, bot_right_limit.y)
