extends RigidBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 1600.0

var state: String = "down"

func _physics_process(delta: float) -> void:	
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	
	if (abs(direction.x) > 0):
		state = "side"
	elif (direction.y > 0):
		state = "down"
	elif direction.y != 0:
		state = "up"
	
	if (direction.x > 0):
		animated_sprite.flip_h = true
	elif (direction.x < 0):
		animated_sprite.flip_h = false
	
	if (direction.length() > 0):
		animated_sprite.play("Walk_" + state)
	else:
		animated_sprite.play("Idle_" + state)
	
	linear_velocity = direction * speed * delta
