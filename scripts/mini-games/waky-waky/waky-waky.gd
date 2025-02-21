extends Node2D

@onready var arm = $Arm as SlideContainer
@onready var alarm = $Alarm as SlideContainer
@onready var gm = $JMTAGRANDMERE
@onready var nk = $NIKOUMOUK

var rdm = RandomNumberGenerator.new()
var trolling = false
var playing = true

func _process(delta: float) -> void:
	if playing && !trolling && is_instance_valid(alarm) :
		if rdm.randi_range(0,9) > 7:
			alarm.pointer.running = false
			trolling = true
			await get_tree().create_timer(0.3).timeout
			if is_instance_valid(alarm):
				alarm.pointer.running = arm.pointer.running
			trolling = false


func _ready() -> void:
	arm.pointer.velocity = 300
	alarm.pointer.velocity = 5000


func _on_arm_current_position(pos: Vector2) -> void:
	gm.global_position = pos


func _on_jmtagrandmere_motion(state: bool) -> void:
	if is_instance_valid(arm) && is_instance_valid(alarm):
		arm.pointer.running = !state
		alarm.pointer.running = !state && !trolling



func _on_alarm_current_position(pos: Vector2) -> void:
	nk.global_position = pos


func _on_nikoumouk_body_entered(body: Node2D) -> void:
	playing = false
	win()

func win():
	stop()
	$CanvasLayer/Victory.modulate.a = 1
	
func game_over():
	stop()
	$CanvasLayer/GameOver.modulate.a = 1

func stop():
	gm.playing = false
	arm.queue_free()
	alarm.queue_free()
	$CanvasLayer/Timer.queue_free()
	

func _on_timer_on_timeout() -> void:
	game_over()


func _on_area_2d_body_entered(body: Node2D) -> void:
	#BUG : Crash si tu touche a 00.1 sec
	print("ouch")
	$CanvasLayer/Timer.current_duration -= 10
