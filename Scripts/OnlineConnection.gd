extends Node

const PORT := 7777

var peer = ENetMultiplayerPeer.new()

func host_server():
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	print("Server Created, PORT:" + str(PORT))
	
func join_server(ip: = "localhost", port: = PORT):
	peer.create_client(ip, port)
	multiplayer.multiplayer_peer = peer
	
