extends Node2D

@export var attack_scenes: Array[PackedScene]

func _ready():
	$AttackSpawnerTimer.start()

func _on_attack_spawner_timer_timeout() -> void:
	if attack_scenes.size() > 0:
		var attack_scene = attack_scenes.pick_random()
		var attack_instance = attack_scene.instantiate()
		add_child(attack_instance)
		$Monologue.play()
