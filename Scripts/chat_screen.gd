extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	OnlineConnection.chat_message_received.connect(_chat_message_received)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_send_message_button_pressed():
	OnlineConnection.send_chat_message_to_all.rpc(OnlineConnection.main_username, %MessageTextEdit.text)
	%MessageTextEdit.text = ""

func _chat_message_received(message):
	%ChatRichTextLabel.text += message
