class_name ObstacleJournalope
extends Sprite2D

@export var particle: GPUParticles2D

@onready var animation_player: AnimationPlayer = $Journalope/AnimationPlayer
@onready var sprite: AnimatedSprite2D = $Journalope/sprite

var show_up_timer: Timer
var hide_timer: Timer
var warn_timer: Timer

var originalPosX

var is_journalistic = false
var has_warn = false

func _ready() -> void:
	animation_player.connect("animation_finished", _on_animation_player_animation_finished)
	
	warn_timer = Timer.new()
	warn_timer.autostart = false
	warn_timer.one_shot = true
	warn_timer.wait_time = randf_range(0.0, 1.0)
	add_child(warn_timer)
	warn_timer.connect("timeout", warn)
	
	show_up_timer = Timer.new()
	show_up_timer.autostart = false
	show_up_timer.one_shot = true
	show_up_timer.wait_time = 2.0
	add_child(show_up_timer)
	show_up_timer.connect("timeout", showJournalist)
	
	hide_timer = Timer.new()
	hide_timer.autostart = false
	hide_timer.one_shot = true
	hide_timer.wait_time = randf_range(1.0, 2.0)
	add_child(hide_timer)
	hide_timer.connect("timeout", hideJournalist)
	
	originalPosX = global_position.x

func setJournalistOn():
	#print("Journalist set")
	is_journalistic = true

func warn():
	#print("Warn on")
	particle.emitting = true
	show_up_timer.start()
	AudioManager.hiding_sounds.play()

func showJournalist():
	AudioManager.hiding_sounds.stop()
	particle.emitting = false
	animation_player.play("show_up")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "show_up"):
		AudioManager.paparazzi.play()
		sprite.play()
		Journalope.instance.isJournalistShowed = true
		#print("Journalist are shown up")
		hide_timer.start()

func hideJournalist():
	sprite.stop()
	AudioManager.paparazzi.stop()
	animation_player.play("hide")
	Journalope.instance.isJournalistShowed = false
	#print("Journalist are hidden")

func _process(delta: float) -> void:
	if (is_journalistic && global_position.x < 75 && !has_warn):
		#print("Timer warn begin")
		has_warn = true
		warn_timer.start()
	if (global_position.x <= -200):
		queue_free()
