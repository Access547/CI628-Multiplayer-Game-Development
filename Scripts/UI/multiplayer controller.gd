extends Control

@export var address = "127.0.0.1"
@export var port = 8910


var peer

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)
	multiplayer.connected_to_server.connect(ConnectedToServer)
	multiplayer.connection_failed.connect(ConnectionFailed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Called on server and clients
func PlayerConnected(id):
	print("Player Connected! ID: " + str(id))

#Called on server and clients
func PlayerDisconnected(id):
	print("Player Disconnected! ID: " + str(id))

#Called only from clients
func ConnectedToServer():
	print("Connected to Server!")
	SendPlayerInformation.rpc_id(1, $LineEdit.text, multiplayer.get_unique_id())

#Called only from clients
func ConnectionFailed():
	print("Couldn't connect to server :[")


@rpc("any_peer")
func SendPlayerInformation(name, id):
	
	if !GameManager.players.has(id):
		GameManager.players[id] = {
			"name": name,
			"id": id
		}
		
	if multiplayer.is_server():
		for i in GameManager.players:
			SendPlayerInformation.rpc(GameManager.players[i], i)


@rpc("any_peer", "call_local")
func StartGame():
	var scene = load("res://Scenes/Levels/Catacombs.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()



func _on_host_pressed():
	peer = ENetMultiplayerPeer.new()
	
	var error = peer.create_server(8910, 8)
	if error != OK:
		print("cannot host: " + error)
		return
		
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for players...")
	SendPlayerInformation($LineEdit.text, multiplayer.get_unique_id())

	
func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	multiplayer.set_multiplayer_peer(peer)


func _on_start_game_pressed():
	StartGame.rpc()
