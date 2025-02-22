class_name StrongArm extends CharacterBody2D

signal motion(state:bool)

var mooving = false
var reached = false
var forward = true
var playing = true

var max_dist = 600
@onready var starting: Vector2 = Vector2.ZERO
@onready var animation = $AnimationPlayer


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if playing:
			if !animation.is_playing():
				animation.play("hit")
				await get_tree().create_timer(0.3).timeout
				AudioManager.hit.play()
		elif (GameManager.story_mode):
			GameManager.next_scene_to_call = "scene_grand_mother"
			if(get_parent()):
				get_parent().queue_free()
		elif (!GameManager.story_mode):
			GameManager.next_scene_to_call = "chapter_menu"
			if(get_parent()):
				get_parent().queue_free()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	motion.emit(true)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	motion.emit(false)
