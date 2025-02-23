extends Node2D

@onready var baker = $Baker as Area2D
@onready var baker_pattern = $"Baker-Patern" as SlideContainer

func _ready() -> void:
	AudioManager.defeat_music.stop()
	AudioManager.baker_music.play()
	baker_pattern.pointer.direction = Vector2.DOWN
	baker_pattern.pointer.velocity = 60


func _on_baker_patern_current_position(pos: Vector2) -> void:
	baker.global_position = pos

func _process(delta: float) -> void:
	
	if is_instance_valid(baker_pattern) and is_safe()  and RandomNumberGenerator.new().randi_range(1,100) > 98 :
		baker_pattern.reverse()
	
func is_safe():
	var y = baker.global_position.y
	return y > -35 && y < 35

func win():
	stop()
	$CanvasLayer/Victory.modulate.a = 1
	$CanvasLayer/IndicationText.visible = false
	await get_tree().create_timer(0.6).timeout
	$YES.play()
	
func game_over():
	if !baker.proud : return
	$NO.play()
	AudioManager.defeat_music.play()
	stop()
	$CanvasLayer/GameOver.modulate.a = 1
	$CanvasLayer/IndicationText.visible = false

func stop():
	AudioManager.baker_music.stop()
	$Fighter.playing = false
	baker.proud = false
	if is_instance_valid(baker_pattern):
		baker_pattern.queue_free()


func _on_baker_area_entered(area: Area2D) -> void:
	area.find_child("Slap").stop()
	$Slap.play()
	win()


func _on_fighter_explode() -> void:
	game_over() # Replace with function body.
