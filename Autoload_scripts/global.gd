extends Node
#Settings Variables
var music_vol = 0
var sfx_vol = 0
var bot_vol = 0
#UI Variables
var time_hr = 23
var time_min = 0
var battery = 5
#Calling Variables
var last_scene = ["res://Assets/Watch_UI/watch_screen_login.tscn"]
var cur_num = ""
var cur_num_seq = []
var cur_calling_transition_name = ""

'''Change this please like why there are global'''

var all_bots = {"0":"res://Assets/Bots/unavailable_bot.tscn",
				"4047432740":"res://Assets/Bots/bank_bot.tscn",
				"0703581654":"res://Assets/Bots/restaurant_bot.tscn"}


func change_scene(scene:String):
	var scene_load = load(scene)

	var main_node = get_node("../MainScreen/WatchOverlay/Main/Panel/VBoxContainer/Screen")

	main_node.add_child(scene_load.instantiate())
	main_node.remove_child(main_node.get_child(0))

func swap_scene(last,new):
	last_scene.append(last)
	change_scene(new)

func set_current_call(num_str:String,num_seq:Array):
	cur_num = num_str
	cur_num_seq = num_seq

func reset_current_call():
	set_current_call("",[])

func set_no_caller(seq):
	set_current_call("0",seq)

func set_current_call_transition_name(name):
	cur_calling_transition_name = name
