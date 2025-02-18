extends Area2D

@onready var start = $Start 
@onready var end = $End
@onready var mid = $Mid

var state : String = "moving"

func _ready() -> void:
	
