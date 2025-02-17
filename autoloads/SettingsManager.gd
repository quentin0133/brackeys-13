extends Node

@onready var keybind_ressource : KeybindRessource = preload("res://assets/resources/settings/DefaultKeybind.tres")

var master_volume : float = 0.0
var sound_volume : float = 0.0
var music_volume : float = 0.0

var settings_dict :Dictionary


func _ready():
	settings_dict = create_storage_dictionary()


func create_storage_dictionary()-> Dictionary:
	var _settings_dict : Dictionary= {
		"master_volume": master_volume,
		"sound_volume": sound_volume,
		"music_volume": music_volume,
		"keybinds" : create_keybinds_dictionary(),
		"keybinds_name" : create_keybinds_name_dictionary()
	}
	return _settings_dict


func create_keybinds_dictionary() -> Dictionary:
	var keybinds_dict = {
		keybind_ressource.MOVE_LEFT : keybind_ressource.DEFAULT_MOVE_LEFT_KEY,
		keybind_ressource.MOVE_RIGHT : keybind_ressource.DEFAULT_MOVE_RIGHT_KEY,	
		keybind_ressource.MOVE_UP : keybind_ressource.DEFAULT_MOVE_UP_KEY,	
		keybind_ressource.MOVE_DOWN : keybind_ressource.DEFAULT_MOVE_DOWN_KEY,	
		keybind_ressource.JUMP : keybind_ressource.DEFAULT_JUMP,	
		keybind_ressource.ATTACK : keybind_ressource.DEFAULT_ATTACK,	
		keybind_ressource.ACTION : keybind_ressource.DEFAULT_ACTION,
	}
	return keybinds_dict


func create_keybinds_name_dictionary() -> Dictionary:
	var keybinds_name_dict = {
		keybind_ressource.MOVE_LEFT : "Left",
		keybind_ressource.MOVE_RIGHT : "Right",	
		keybind_ressource.MOVE_UP : "Up",	
		keybind_ressource.MOVE_DOWN : "Down",	
		keybind_ressource.JUMP : "Jump",	
		keybind_ressource.ATTACK : "Attack",	
		keybind_ressource.ACTION : "Action",
	}
	return keybinds_name_dict


func rest_keybinds_dictionary() -> void:
	var keybinds_dict = {
		keybind_ressource.MOVE_LEFT : keybind_ressource.DEFAULT_MOVE_LEFT_KEY,
		keybind_ressource.MOVE_RIGHT : keybind_ressource.DEFAULT_MOVE_RIGHT_KEY,	
		keybind_ressource.MOVE_UP : keybind_ressource.DEFAULT_MOVE_UP_KEY,	
		keybind_ressource.MOVE_DOWN : keybind_ressource.DEFAULT_MOVE_DOWN_KEY,	
		keybind_ressource.ATTACK : keybind_ressource.DEFAULT_ATTACK,	
		keybind_ressource.ACTION : keybind_ressource.DEFAULT_ACTION,
	}
	settings_dict["keybinds"] = keybinds_dict
