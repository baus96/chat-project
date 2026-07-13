extends Control


func _ready():
	OnlineConnection.join_server()

func _on_login_button_pressed() -> void:
	if %LineEditUsername.text != "" and %LineEditPassword.text != "":
		OnlineConnection.send_login_data_to_server.rpc_id(1 ,%LineEditUsername.text, %LineEditPassword.text)

func _on_register_button_pressed() -> void:
	if %LineEditUsername.text != "" and %LineEditPassword.text != "":
		OnlineConnection.send_register_data_to_server.rpc_id(1 ,%LineEditUsername.text, %LineEditPassword.text)
