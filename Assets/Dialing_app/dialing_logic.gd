extends GridContainer

@onready var audio_player = $AudioStreamPlayer
@onready var beep_player = $BeepPlayer # Reference to the AudioStreamPlayer
@onready var dialing_num = $"../CurNum"

var can_proceed = false # nvm you can skip the audio
var dial_sequence = []
var target_length = 10
var target_sequence = [[8,8,8,6,6,0,5,8,1,0],[4,0,4,7,4,3,2,7,4,0], [6,4,6,5,1,5,0,0,5,4]]

var current_directory_path = "res://audio/voicebot1_main/"  # Start path
var folder_structure = {}
var current_node_array = []

func _ready():
	
	#Set Number Dialing to nothing
	dialing_num.text = ""
	
	# Connect the finished signal of the AudioStreamPlayer
	audio_player.connect("finished", Callable(self, "_on_audio_finished"))

	# Connect button signals
	for button in self.get_children():
		if button.is_in_group("NumBtn"):
			button.connect("pressed", Callable(self, "_on_button_pressed_dial").bind((button.name.to_int())))

			
func _on_audio_finished():
	can_proceed = true  # Allow button main functions to proceed now that audio has finished

func _on_button_pressed_dial(value):
	if value == 9: #Set broken number button
		return
	
	if len(dial_sequence) < target_length:
		play_beep_sound()
		#Show What Number You're Calling
		dialing_num.text += str(value)
		dial_sequence.append(value)

func play_beep_sound():
	beep_player.play()

func _on_button_call_pressed() -> void:
	play_beep_sound()
	# Check if the entered sequence matches the target sequence
	# prioitize calling Callie 
	if dial_sequence == [6,4,6,5,1,5,0,0,5,4]:
		#Global.swap_scene("res://Assets/Dialing_app/watch_screen_dialing.tscn",'res://Assets/Cut_scenes/Good_Ending1/Gooding_Ending1.tscn')
		#get_tree().current_scene.queue_free()
		#get_tree().change_scene_to('res://Assets/Cut_scenes/Good_Ending1/Gooding_Ending1.tscn')
		get_tree().change_scene_to_file('res://Assets/Cut_scenes/Good_Ending1/Gooding_Ending1.tscn')
		#Global.change_scene('res://Assets/Cut_scenes/Good_Ending1/Gooding_Ending1.tscn')
		print("enter good ending")
	
	elif dial_sequence in target_sequence:
		Dialing_Global.set_current_call(dialing_num.text,dial_sequence)
		Global.swap_scene("res://Assets/Dialing_app/watch_screen_dialing.tscn","res://Assets/Dialing_app/watch_screen_calling.tscn")
		print("Correct sequence entered.")
		
	else:
		Dialing_Global.set_current_call('0',dial_sequence)
		Global.swap_scene("res://Assets/Dialing_app/watch_screen_dialing.tscn","res://Assets/Dialing_app/watch_screen_calling.tscn")
		print("sorry, but incorrect number lol")
		
		
		#execute_main_logic()

func _on_button_del_pressed() -> void:
	play_beep_sound()
	dial_sequence.pop_back()  # Delete last number entered
	dialing_num.text = ""
	for num in dial_sequence: # Update ui to show changed dialing sequence
		dialing_num.text += str(num) 
