extends Button

@export var cont_name:String
@export var number:String
@export var callable:bool= false
@export var contact_img: Texture2D

@onready var contact_name = $HBoxContainer/VBoxContainer/ContactName
@onready var contact_number = $HBoxContainer/VBoxContainer/ContactNumber
@onready var contact_icon_frame = $HBoxContainer/ContactIcon
@onready var initial = $HBoxContainer/ContactIcon/Initial

var contact_sequence:Array[int]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Set Contact Name
	contact_name.text = cont_name

	#Set Contact Number
	contact_number.text = number

	#Turn number string to array
	for i in number:
		contact_sequence.append(int(i))

	if contact_img != null:
		initial.text = ""
		contact_icon_frame.texture = contact_img
	else:
		#Set Initial for Contact
		initial.text = cont_name[0]


func _on_pressed() -> void:
	$AudioStreamPlayer.play()
	if callable:
		Dialing_Global.set_current_call(contact_number.text,contact_sequence)
	else:
		Dialing_Global.set_no_caller(contact_sequence)
	Dialing_Global.set_current_call_transition_name(cont_name)
	Dialing_Global.from_contacts = true # if the you make the phone call from contacts
	Global.swap_scene("res://Assets/Dialing_app/watch_screen_contacts.tscn","res://Assets/Dialing_app/watch_screen_calling.tscn")
