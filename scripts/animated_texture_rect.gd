@tool
class_name AnimatedTextureRect
extends TextureRect

@export var sprites: SpriteFrames
@export var current_animation = "default"
@export var frame_index = 0
@export_range(0.0, INF, 0.001) var speed_scale = 1.0
@export var auto_play = false
var playing = false
var refresh_rate = 1.0
var fps = 30.0
var frame_delta = 0

func _ready() -> void:
	fps = sprites.get_animation_speed(current_animation)
	refresh_rate = sprites.get_frame_duration(current_animation, frame_index)
	if (auto_play):
		play()

func _process(delta: float) -> void:
	if sprites == null || !playing:
		return
	update_animation_data(current_animation)
	frame_delta += speed_scale * delta
	if (frame_delta >= refresh_rate / fps):
		texture = get_next_frame()
		frame_delta = 0.0

func get_next_frame():
	frame_index += 1
	var frame_count = sprites.get_frame_count(current_animation)
	if (frame_index >= frame_count):
		frame_index = 0
		if !sprites.get_animation_loop(current_animation):
			playing = false
	update_animation_data(current_animation)
	return sprites.get_frame_texture(current_animation, frame_index)

func play(animation_name: String = current_animation):
	frame_index = 0
	frame_delta = 0.0
	if !sprites.has_animation(current_animation):
		playing = false
		assert(false, "Animation %s doesn't exist" % current_animation)
	current_animation = animation_name
	update_animation_data(current_animation)
	playing = true

func update_animation_data(animation: String):
	fps = sprites.get_animation_speed(current_animation)
	refresh_rate = sprites.get_frame_duration(current_animation, frame_index)

func resume():
	playing = true

func pause():
	playing = false

func stop():
	frame_index = 0
	playing = false
