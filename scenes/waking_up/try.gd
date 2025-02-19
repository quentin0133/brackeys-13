extends Node2D

@onready var arm = $Arm as SlideContainer
@onready var alarm = $Alarm as SlideContainer
@onready var gm = $JMTAGRANDMERE
@onready var nk = $NIKOUMOUK

func _ready() -> void:
	arm.pointer.velocity = 250
	alarm.pointer.velocity = 600


func _on_arm_current_position(pos: Vector2) -> void:
	gm.global_position = pos
	gm.flip_h = arm.pointer.direction.x < 0


func _on_alarm_current_position(pos: Vector2) -> void:
	nk.global_position = pos
