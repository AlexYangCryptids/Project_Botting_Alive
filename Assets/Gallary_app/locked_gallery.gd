extends Button


func _on_pressed() -> void:
	$Panel.visible = true
	
func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE) and $Panel.visible == true:
		$Panel.visible = false
	

func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text == "0302":
		pass
