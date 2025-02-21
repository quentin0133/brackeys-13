extends Node

var next_scene_to_call : String = "main_menu"
var story_mode : bool = true
var in_game : bool = false

var data_game = {
	"scene_journalope" : ['Journalope','Description','Journalist avoided','Best Score','Last Score',0,0],
	"scene_wakywaky" : ['title','Description','Score hud','Best Score','Last Score',0,0],
	"scene_dont_answer" : ['title','Description','Score hud','Best Score','Last Score',0,0],
	"scene_crowd_kid" : ['title','Description','Score hud','Best Score','Last Score',0,0],
	"scene_grand_mother" : ['title','Description','Score hud','Best Score','Last Score',0,0],
	"main_menu" : ['Default title','Default description','Score hud','Best Score','Last Score',0,0]
	
}

func update_score(scene_name: String):
	if data_game[scene_name][6]  > data_game[scene_name][5] :
		data_game[scene_name][5] = data_game[scene_name][6] 
#GrandMa game
var select_obstacle :int = 0
