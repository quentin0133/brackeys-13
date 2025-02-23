class_name Bullet extends Area2D

#static var explo = preload("res://assets/UFO/explo.tscn")


var velocity = Vector2.LEFT * 40
@onready var parent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(velocity * delta)

func _on_body_entered(body: Node2D) -> void:
	#var e = explo.instantiate()
	#e.global_position = global_position
	#parent.add_child(e)
	queue_free()
