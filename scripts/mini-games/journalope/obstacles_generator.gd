class_name ObstacleGeneratorJournalope
extends Node2D

@export var obstaclesPrefab: Array[PackedScene]

@onready var ground = $"../Ground"

const MIN_Y = -25
const MAX_Y = 15

var count = 0
var obstacles: Array[ObstacleJournalope] = []
var originPos
var is_generating = true
var obstacle_counter_spawn_journalist = 3

func _ready() -> void:
	originPos = global_position

func _process(delta: float) -> void:
	if (is_generating):
		count -= delta
	if (count <= 0.0):
		generateObstacle()

func generateObstacle():
	var obstacleIndex = randi_range(0, obstaclesPrefab.size() - 1)
	var obstacleInstance = obstaclesPrefab[obstacleIndex].instantiate() as ObstacleJournalope
	ground.add_child(obstacleInstance)
	obstacleInstance.global_position = Vector2(global_position.x, randf_range(MIN_Y, MAX_Y))
	obstacles.append(obstacleInstance)
	count = randf_range(0.75, 1.5)
	obstacle_counter_spawn_journalist -= 1
	if (obstacle_counter_spawn_journalist == 0):
		obstacle_counter_spawn_journalist = randi_range(2, 6)
		obstacleInstance.setJournalistOn()

func pause():
	is_generating = false

func resume():
	is_generating = true
