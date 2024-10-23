extends Node

const SERVER = "127.0.0.1"
const PORT = 8000
var peer


func _ready():
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)

	peer = ENetMultiplayerPeer.new()
	peer.create_client(SERVER, PORT)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)

	multiplayer.set_multiplayer_peer(peer)


func connected_to_server():
	print("connected To Sever!")


func connection_failed():
	print("Couldnt Connect")
