class_name Fighter extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
static var slap = preload("res://scenes/minigames/beat-baker/slap.tscn")

@export var speed = 1600.0

var state: String = "down"

var cooldown = 1.0
var playing = true

var baguettes = 0
signal explode

func _physics_process(delta: float) -> void:	
	if !playing:
		return
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
	
	velocity = direction * speed * delta
	move_and_slide()
	z_index = global_position.y
	cooldown -= delta

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and cooldown <= 0:
		if playing:
			var s = slap.instantiate() as Path2D
			s.scale = Vector2(0.339,0.26)
			add_child(s)
			s.move_local_x(2)
			s.move_local_y(-6)
			cooldown = 1.0
		elif (GameManager.story_mode):
			GameManager.next_scene_to_call = "main_menu"
			if(get_parent()):
				get_parent().queue_free()
		elif (!GameManager.story_mode):
			GameManager.next_scene_to_call = "chapter_menu"
			if(get_parent()):
				get_parent().queue_free()

func eat(): 
	baguettes += 1
	if baguettes <= 3:
		var s = Vector2(baguettes / 2.5, baguettes / 2.5)
		$AnimatedSprite2D.scale = s + $AnimatedSprite2D.scale
		$CollisionShape2D.scale = s + $CollisionShape2D.scale
	else:
		explode.emit()
