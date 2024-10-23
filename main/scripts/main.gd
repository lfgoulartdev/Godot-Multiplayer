extends Node

var SERVER_SCENE = "res://server/scenes/server.tscn"
var CLIENT_SCENE = "res://client/scenes/client.tscn"


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	pass


func _on_open_server_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", SERVER_SCENE)


func _on_open_client_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", CLIENT_SCENE)
