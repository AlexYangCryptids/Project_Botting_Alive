extends Node2D

var shake_strength: float = 0.0
var DECAY_RATE: float = 5.0

func _ready() -> void:
	print('playing')
	$AnimationPlayer.play()
	await $AnimationPlayer.animation_finished
	print('done!')
	finished()

func finished():
	#$AnimationPlayer.play("fade_out")
	#await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file('res://Assets/Cut_scenes/Post_Credit1/Post_Credit1.tscn')

func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		finished()
