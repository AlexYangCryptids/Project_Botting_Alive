extends Bot


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	run()
	entry.call()

var entry = func greeting():
	reset()
	play_audio("res://audio/RestaurantBot/entry.mp3")
	
	target = ["1","2","3"]
	
	await input_recieved
	
	if cur_num == "3":
		dispute_1()
	elif cur_num == "1":
		place_order.call()
	elif cur_num == "2":
		order_catering_3()
		
func dispute_1():
	reset()
	play_audio("res://audio/RestaurantBot/dispute.mp3")
	
	target = ["05008"]
	await input_recieved
	
	if cur_num in target:
		correct_reciept()
	
func correct_reciept():
	reset()
	play_audio("res://audio/RestaurantBot/correct_receipt.mp3")
	await  finished
	play_audio("res://audio/RestaurantBot/finish the job.mp3")
	await  finished
	get_tree().change_scene_to_file("res://Assets/Cut_scenes/Bad_Ending1/bad_ending1.tscn")
	
var place_order = func place_order_2():
	reset()
	play_audio("res://audio/RestaurantBot/place_order.mp3")
	
	target = ["0","1","2","3"]
	await  input_recieved
	if cur_num == "0":
		entry.call()
	elif cur_num == "1":
		add_entree_1()
	elif cur_num == "2":
		add_pasta_2()
	elif cur_num == "3":
		if Unlockable.OrderPlaced == true:
			check_out_3()
		else:
			place_order.call()
	
func add_entree_1():
	reset()
	play_audio("res://audio/RestaurantBot/add_entree.mp3")
	
	target = ["0","1","2","3","4"]
	await input_recieved
	if cur_num in ["1","2","3","4"]:
		Unlockable.OrderPlaced = true
		place_order.call()
	else:
		place_order.call()
		
func add_pasta_2():
	reset()
	play_audio("res://audio/RestaurantBot/add_pasta.mp3")
	
	target = ["1","2","3","4"]
	await input_recieved
	if cur_num in ["1","2","3","4"]:
		Unlockable.OrderPlaced = true
		place_order.call()
	else:
		place_order.call()
		
func check_out_3():
	reset()
	play_audio("res://audio/RestaurantBot/check_out.mp3")
	
	target = ["1","2"]
	await input_recieved
	
	
	if cur_num in target:
		card_info()
		
func card_info():
	reset()
	play_audio("res://audio/RestaurantBot/card_info.mp3")
	
	target = ["42076613"]
	await input_recieved
	
	if cur_num in target:
		order_catering_3()

func order_ready():
	reset()
	play_audio("res://audio/RestaurantBot/order_ready.mp3")
	
	await  finished
	hangup()
	
func order_catering_3():
	reset()
	play_audio("res://audio/RestaurantBot/catering.mp3")
	play_audio("res://audio/RestaurantBot/zip_code.mp3")

	target = ["30310"]
	await input_recieved
	
	if cur_num in target:
		delivery_ending()
	
func delivery_ending():
	reset()
	play_audio("res://audio/RestaurantBot/delivery_ordered.mp3")
	await  finished
	await get_tree().create_timer(2.0).timeout
	play_audio("res://audio/RestaurantBot/finish the job.mp3")
	await  finished
	get_tree().change_scene_to_file("res://Assets/Cut_scenes/Bad_Ending1/bad_ending1.tscn")

func _exit_tree() -> void:
	Unlockable.OrderPlaced =  false
