extends Control



func _on_login_button_pressed() -> void:
	pass

func _on_register_button_pressed() -> void:
	if %LineEditUsername.text != null and %LineEditPassword.text != null:
		OnlineConnection.send_register_data_to_server.rpc_id(1 ,%LineEditUsername.text, %LineEditPassword.text)
