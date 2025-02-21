class_name StrongArm extends Sprite2D

signal motion(state:bool)

var mooving = false
var reached = false
var forward = true

var max_dist = 600
@onready var starting: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	if(mooving):
		if !reached :
			move_within(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if !mooving:
			motion.emit(true)
			starting = global_position
			mooving = true
			forward = true
			reached = false

func move_within(delta: float):
	global_position = global_position.move_toward(
		(global_position + (Vector2.DOWN * max_dist) if forward else starting),
		600 * delta
	)
	var dist = global_position.distance_to(starting)
	if forward && dist >= max_dist:
		forward = false
	elif !forward && !dist:
		reached = true
		mooving = false
		motion.emit(false)
	
