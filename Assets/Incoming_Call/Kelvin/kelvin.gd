extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer_ringtone.play()
	#get_node("../../UIBG/UI/Time").visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var time_str = ""
	if Global.time_hr < 10: #Adds 0 infront of single digit number
		time_str += "0" + str(Global.time_hr)
	else:
		time_str += str(Global.time_hr)

	time_str += ":"

	if Global.time_min < 10:#Adds 0 infront of single digit number
		time_str += "0" + str(Global.time_min)
	else:
		time_str += str(Global.time_min)

	$Time.text = time_str


func _on_accept_call_pressed() -> void:
	$Button.disabled = true
	$AudioStreamPlayer_ringtone.stop()
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	$AudioStreamPlayer2.play()
	await $AudioStreamPlayer2.finished

	Global.swap_scene("res://Assets/Incoming_Call/Kelvin.tscn","res://Assets/Watch_UI/watch_screen_login.tscn")
