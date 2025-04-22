extends Control

@export var images:Array[Texture2D]
@export var info:Array[String]

@onready var view_image = $View/VBoxContainer/ViewImg
@onready var view = $View
@onready var view_label = $View/VBoxContainer/Label

@onready var audio_player = $AudioStreamPlayer

var hovering = false
var cur_img = null
var cur_index = 0
var hovering_view_image = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	view.visible = false
	#var i = 1
	for i in images.size()-1:
		i += 1
		print(i)
		var image = images[i]
		var child = TextureRect.new()
		child.texture = image
		child.custom_minimum_size = Vector2(200,200)
		child.connect("mouse_entered",_on_mouse_entered.bind(image,i))
		child.connect("mouse_exited",_on_mouse_exited)
		$ScrollContainer/GridContainer.add_child(child)
	

func _input(event: InputEvent):
	if event is InputEventMouseButton:
	
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and hovering and view.visible==false:
			view_image.texture = cur_img
			view.visible = true
			view_label.text = info[cur_index]
			audio_player.play()
			
		if  Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and view.visible==true and hovering_view_image==true:
			view.visible = false
			view_image.texture = null
			audio_player.play()
	if Input.is_key_pressed(KEY_ESCAPE) and $Panel.visible == true:
		$Panel.visible = false

func _on_mouse_entered(img,idx):
	hovering = true
	cur_img = img
	cur_index = idx
	
func _on_mouse_exited():
	hovering = false


func _on_view_mouse_entered() -> void:
	hovering_view_image = true

func _on_view_mouse_exited() -> void:
	hovering_view_image = false


func _on_control_pressed() -> void:
	$Panel.visible = true
	hovering = false
	

func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text == "0302":
		$Panel.visible = false
		cur_img = images[0]
		cur_index = 0
		view_image.texture = cur_img
		view.visible = true
		view_label.text = info[cur_index]
		audio_player.play()
		


func _on_line_edit_editing_toggled(toggled_on: bool) -> void:
	var new_text = $Panel/VBoxContainer/LineEdit.text
	if new_text == "0302":
		$Panel.visible = false
		cur_img = images[0]
		cur_index = 0
		view_image.texture = cur_img
		view.visible = true
		view_label.text = info[cur_index]
		audio_player.play()
