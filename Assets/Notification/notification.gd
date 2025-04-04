class_name Notification
extends ColorRect

enum TargetState {
	MESSAGES,
}

const MAX_TIME: float = 5.0
const FADE_TIME: float = 1.0
var _target_state: TargetState

var _title_label: Label
var _subtitle_label: Label

var _fade_objects: Array[Control]

var remaining_time: float

func init(title: String, subtitle: String, target_state: TargetState) -> void:
	_title_label = $Title
	_subtitle_label = $Subtitle
	_fade_objects = [self, _title_label, _subtitle_label]
	_title_label.text = title
	_subtitle_label.text = subtitle
	_target_state = target_state

	remaining_time = MAX_TIME

func _process(delta: float) -> void:
	remaining_time -= delta
	if remaining_time < 0.0:
		queue_free()
	elif remaining_time < FADE_TIME:
		var ratio: float = remaining_time / FADE_TIME
		for object in _fade_objects:
			object.self_modulate = Color(1, 1, 1, ratio)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			accept_event()
			interact()

func interact() -> void:
	match _target_state:
		TargetState.MESSAGES:
			Global.change_scene("res://Assets/Message_app/watch_screen_texts.tscn")
