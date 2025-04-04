extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("../../UIBG/UI/Time").visible = false

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


'''
todo: press the mouse the make it work
'''
func _on_texture_rect_mouse_entered() -> void:
	$AnimationPlayer.play("fade_out")
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	get_node("../../UIBG/UI/Time").visible = true
	Global.swap_scene("res://Assets/Watch_UI/watch_screen_login.tscn","res://Assets/Watch_UI/watch_screen_apps.tscn")
