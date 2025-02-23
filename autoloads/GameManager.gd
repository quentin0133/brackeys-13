extends Node

var next_scene_to_call : String = "main_menu"
var story_mode : bool = true
var story_mode_finish : bool = true
var in_game : bool = false
var show_score : bool = false
var time_score : String = "00:000"

var timer_hud : int = 10
var timer_timeout: bool = false
var show_timer_hud : bool = false
var timer_lock : bool = false

var data_game = {
	"scene_journalope" : ['The \'Journalope\'','Run and hide from journalists',0,'Best sprint','Last sprint',0,0,true],
	"scene_crowd_kid" : ['Crow and Kid','Description',1,'','Last time','',time_score,true],
	"scene_wakywaky" : ['Waky waky','Cross the crowd and tackle the kid',2,'','',0,0,false],
	"scene_grand_mother" : ['Grand Mother Game','Looking for Granny\'s medicine',3,'','Last time','',time_score,true],
	"scene_dont_answer" : ['Father Fouras','Ignore it and run away',4,'','','','',false],
	"scene_monologue" : ['Boring monologue','Dodging boring nerd monologues',5,'','',0,0,false]
	#"main_menu" : ['Default title','Default description','Score hud','Best Score','Last Score',0,0,false]
}

func update_score(scene_name: String):
	if data_game[scene_name][6]  > data_game[scene_name][5] :
		data_game[scene_name][5] = data_game[scene_name][6] 


#GrandMa game
var select_obstacle :int = 0
#GameManager.story_mode_finish = true
