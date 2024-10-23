extends Node

const PORT: int = 8000
const MAX_CONNECTIONS = 100

var players: Dictionary = {}
var players_loaded: int = 0


func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)

	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_CONNECTIONS)

	if error != OK:
		print("Server error: " + error)
		return

	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)

	multiplayer.set_multiplayer_peer(peer)

	print("Server is up! Listening port: ", PORT)


func peer_connected(id):
	print("Player connected " + str(id))
	players[id] = {"nickname": str(id)}


func peer_disconnected(id):
	print("Player Disconnected " + str(id))
	players.erase(id)
