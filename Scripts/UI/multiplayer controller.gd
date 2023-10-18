extends Control

@export var address = "90.214.148.221"
@export var port = 8910

@onready var displayName = $Name

var peer
var classSelected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Name.text = GameManager.names.pick_random()
	
	
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)
	multiplayer.connected_to_server.connect(ConnectedToServer)
	multiplayer.connection_failed.connect(ConnectionFailed)
	
	if "--server" in OS.get_cmdline_args():
		HostGame()
		print(address)
	

#Called on server and clients
func PlayerConnected(id):
	print("Player Connected! ID: " + str(id))

#Called on server and clients
func PlayerDisconnected(id):
	print("Player Disconnected! ID: " + str(id))
	GameManager.players.erase(id)
	var players = get_tree().get_nodes_in_group("Player")
	for i in players:
		if i.name == str(id):
			i.queue_free()
#Called only from clients
func ConnectedToServer():
	print("Connected to Server!")
	SendPlayerInformation.rpc_id(1, displayName.text, multiplayer.get_unique_id(), classSelected)

#Called only from clients
func ConnectionFailed():
	print("Couldn't connect to server :[")


@rpc("any_peer")
func SendPlayerInformation(name, id, classSelected):
	
	if !GameManager.players.has(id):
		GameManager.players[id] = {
			"name": name,
			"id": id,
			"displayName": displayName.text,
			"class": classSelected
		}
		
	if multiplayer.is_server():
		for i in GameManager.players:
			SendPlayerInformation.rpc(GameManager.players[i], i, GameManager.players[i].class)


func HostGame():
	peer = ENetMultiplayerPeer.new()
	
	var error = peer.create_server(port, 8)
	if error != OK:
		print("cannot host: " + error)
		return
		
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for players...")


@rpc("any_peer", "call_local")
func StartGame():
	var scene = load("res://Scenes/Levels/Catacombs.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()



func _on_host_pressed():
	HostGame()
	SendPlayerInformation(displayName.text, multiplayer.get_unique_id(), classSelected)

	
func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(address, port)
	print(str("Address: ", address))
	print(str("Port: ",port))
	if error != OK:
		print("Can't join")
		return
	multiplayer.set_multiplayer_peer(peer)


func _on_start_game_pressed():
	StartGame.rpc()



func _on_option_button_item_selected(index):
	classSelected = $OptionButton.selected
