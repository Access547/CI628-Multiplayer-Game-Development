@icon("CharacterBody2d")
extends CharacterBody2D
class_name PC

@onready var sprite = $Sprite
@onready var proj = preload("res://Scenes/Attacks/test_proj.tscn")
@onready var projectile_rotation = $"Projectile Rotation"
@onready var weapon_slash = $"Projectile Rotation/Weapon Slash"
@onready var camera = $Camera2D
@onready var display_name_label = $"Display Name Label"




@export var canvasLayer: CanvasLayer
@export var killFeed: Control
@export var stateMachine: StateMachine
@export var multiplayer_synchronizer: MultiplayerSynchronizer
@export var stunComponent: StunComponent
@export var healthComponent: HealthComponent

var SPEED = 100
var spawnPos
var displayName: String
var id

func _ready():
	if name.begins_with("@"):
		multiplayer_synchronizer.set_multiplayer_authority(1)
		#name = "2"
	else:
		multiplayer_synchronizer.set_multiplayer_authority(str(name).to_int())
	
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		camera.make_current()
		spawnPos = position
	
	
func SetUpPlayer(name1: String, playerID: int):
	$"Display Name Label".text = name1
	displayName = name1
	id = playerID
	

func _physics_process(_delta):
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		var directionX = Input.get_axis("Left", "Right")
		if directionX and stateMachine.canMoveCheck():
			velocity.x = (directionX * SPEED)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if get_global_mouse_position().x > global_position.x and stateMachine.canMoveCheck():
			sprite.flip_h = false
		elif get_global_mouse_position().x < global_position.x and stateMachine.canMoveCheck():
			sprite.flip_h = true
			
		var directionY = Input.get_axis("Up", "Down")
		if directionY and stateMachine.canMoveCheck():
			velocity.y = (directionY * SPEED)
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

		move_and_slide()
		
		projectile_rotation.look_at(get_global_mouse_position())

func _process(_delta):
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		if stateMachine.currentState.canAttack:
			if Input.is_action_just_pressed("AbilityL"):
				stateMachine.currentState.transitioned.emit(stateMachine.currentState, "L")
			if Input.is_action_just_pressed("AbilityR"):
				stateMachine.currentState.transitioned.emit(stateMachine.currentState, "R")
			if Input.is_action_just_pressed("AbilitySpace"):
				stateMachine.currentState.transitioned.emit(stateMachine.currentState, "Space")
			if Input.is_action_just_pressed("AbilityE"):
				stateMachine.currentState.transitioned.emit(stateMachine.currentState, "E")
		if Input.is_action_just_pressed("Kill Yourself"):
			healthComponent.TakeDamage(10,displayName, "God")



@rpc("any_peer","call_local")
func fire():
	
	var projectile = proj.instantiate()
	projectile.position = global_position
	projectile.rotation_degrees = projectile_rotation.rotation_degrees
	get_tree().root.add_child(projectile, true)


func Knockback(force: float, direction: Vector2):
	velocity = direction.normalized() * force



@rpc("any_peer", "call_local")
func TakeDamage(amount):
	healthComponent.TakeDamage(amount, name, "dwa")
	print("dwadwa")
