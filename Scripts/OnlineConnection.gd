extends Node

const PORT := 7777

signal chat_message_received(message: String)

var main_username
var peer = ENetMultiplayerPeer.new()

func _ready() -> void:
	# --- HER İKİ TARAFTA DA (Server & Client) ÇALIŞAN SİNYALLER ---
	# Yeni bir oyuncu bağlandığında tetiklenir (Herkes duyar)
	multiplayer.peer_connected.connect(_on_peer_connected)
	# Bir oyuncunun bağlantısı koptuğunda tetiklenir (Herkes duyar)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

	# --- SADECE CLIENT (İSTEMCİ) TARAFINDA ÇALIŞAN SİNYALLER ---
	# Sunucuya başarıyla bağlandığımızda tetiklenir
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	# Sunucuya bağlanma denemesi başarısız olduğunda tetiklenir
	multiplayer.connection_failed.connect(_on_connection_failed)
	# Sunucu kapandığında veya bizi attığında tetiklenir
	multiplayer.server_disconnected.connect(_on_server_disconnected)


func host_server():
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	print("Server Created, PORT:" + str(PORT))
	
func join_server(ip: = "127.0.0.1", port: = PORT):
	peer.create_client(ip, port)
	multiplayer.multiplayer_peer = peer
	print("joined server")
	
	
	# [Server & Client] Herhangi bir oyuncu bağlandığında
func _on_peer_connected(id: int):
	print("Yeni bir oyuncu ağa katıldı! Benzersiz ID: ", id)
	
	
# [Server & Client] Herhangi bir oyuncu ayrıldığında
func _on_peer_disconnected(id: int):
	print("Bir oyuncu ağdan ayrıldı. Benzersiz ID: ", id)
	
	
	
	
# [Sadece Client] Biz sunucuya başarıyla bağlandığımızda
func _on_connected_to_server():
	print("BAŞARILI: Sunucuya bağlandım! Benim ID'm: ", multiplayer.get_unique_id())

# [Sadece Client] Biz sunucuya bağlanmayı başaramadığımızda
func _on_connection_failed():
	print("HATA: Sunucuya bağlanılamadı. Sunucu kapalı olabilir veya IP/Port yanlıştır.")
	

# [Sadece Client] Sunucu çöktüğünde veya bizi disconnet ettiğinde
func _on_server_disconnected():
	print("BİLGİ: Sunucu kapandı veya bağlantınız kesildi!")
	
@rpc("any_peer", "call_remote")
func send_register_data_to_server(Username, Password):
	pass
	
@rpc("any_peer", "call_remote")
func send_login_data_to_server(Username, Password):
	main_username = Username
	
@rpc("authority")
func return_login_result(success: bool, message: String):
	if success:
		print(message)
		get_tree().change_scene_to_file("res://Scenes/chat_screen.tscn")
	else:
		print(message)

@rpc("any_peer", "call_local")
func send_chat_message_to_all(Username, message):
	chat_message_received.emit(str(Username) + ": " + message + "\n")
	
	
	
