extends Control

@onready var animation_player = $AnimationPlayer
var can_accept_input := false

# for pacing control, wait for 5 secs
func _ready() -> void:
	# Start a 5-second timer
	await get_tree().create_timer(1.0).timeout
	can_accept_input = true


# click to play the game
func _input(event: InputEvent) -> void:
	if can_accept_input == true:
		if event is InputEventKey:
			if Input.is_key_pressed(KEY_ESCAPE):
				get_tree().quit()
		if event is InputEventMouseButton:
			#animation_player.play("fade_out")
			get_tree().change_scene_to_file("res://Assets/Cut_scenes/opening/test_OP.tscn")
