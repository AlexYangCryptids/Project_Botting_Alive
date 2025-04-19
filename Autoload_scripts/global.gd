extends Node
#Settings Variables
var music_vol = 0
var sfx_vol = 0
var bot_vol = 0
#UI Variables
var time_hr = 09
var time_min = 07
var battery = 5
#Calling Variables
#var last_scene = ["res://Assets/Watch_UI/watch_screen_login.tscn"]
var scene_seq = ["res://Assets/Watch_UI/watch_screen_login.tscn"]
var current_scene = "res://Assets/Watch_UI/watch_screen_login.tscn" # just here to track the current scene

# basically this is the scene manager

func change_scene(scene:String):
	var scene_load = load(scene)
	var main_node = get_node("../MainScreen/WatchOverlay/Main/Panel/VBoxContainer/Screen")
	#print(scene_load)
	current_scene = scene

	main_node.add_child(scene_load.instantiate()) # new scene on the show
	main_node.remove_child(main_node.get_child(0)) # remove old scene

func swap_scene(last,new):
	# technially we don't need to use swap scene, just change is fine. But i'm just being lazy
	scene_seq.append(last)
	change_scene(new)
	current_scene = new
