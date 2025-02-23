class_name Baker extends Area2D

var cooldown = 0.0
static var bullet = preload("res://scenes/minigames/beat-baker/baguette.tscn")
var rnd = RandomNumberGenerator.new()
var proud = true
signal slapped


func _process(delta: float) -> void:
	if cooldown < 0 and proud:
		shoot()
	else :
		cooldown -= delta
	
func shoot():
	var b: Bullet = bullet.instantiate()
	b.global_position = global_position + (Vector2.LEFT * 15)
	b.z_index = b.global_position.y
	get_parent().add_child(b)
	cooldown = rnd.randf_range(0.2,1)
