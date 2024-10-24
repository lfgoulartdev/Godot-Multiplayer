extends Node

const SERVER: String = "127.0.0.1"
const PORT: int = 8000
const MAX_CONNECTIONS = 100

var players: Dictionary = {}
var players_loaded: int = 0

var peer


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	pass


func _on_open_server_button_pressed() -> void:
	initialize_server()


func _on_open_client_button_pressed() -> void:
	initialize_client()


func initialize_server():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)

	peer = ENetMultiplayerPeer.new()

	var error = peer.create_server(PORT, MAX_CONNECTIONS)

	if error != OK:
		print("Server error: " + error)
		return

	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)

	multiplayer.set_multiplayer_peer(peer)

	print("Server is up! Listening port: ", PORT)


func initialize_client():
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	multiplayer.server_disconnected.connect(connection_lost)
	
	peer = ENetMultiplayerPeer.new()
	peer.create_client(SERVER, PORT)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)

	multiplayer.set_multiplayer_peer(peer)


func peer_connected(id):
	print("Player connected " + str(id))
	players[id] = {"nickname": str(id)}


func peer_disconnected(id):
	print("Player Disconnected " + str(id))
	players.erase(id)


func connected_to_server():
	print("Connected to sever!")


func connection_failed():
	print("Couldnt connect!")


func connection_lost():
	print("Connection lost!")
