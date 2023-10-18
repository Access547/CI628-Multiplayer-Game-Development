@icon("CharacterBody2d")
extends CharacterBody2D
class_name PC

@onready var sprite = $Sprite
@onready var proj = preload("res://Scenes/Attacks/test_proj.tscn")
@onready var projectile_rotation = $"Projectile Rotation"
@onready var weapon_slash = $"Projectile Rotation/Weapon Slash"
@onready var camera = $Camera2D
@onready var display_name_label = $"Display Name Label"


@export var stateMachine: StateMachine
@export var multiplayer_synchronizer: MultiplayerSynchronizer
@export var stunComponent: StunComponent
@export var healthComponent: HealthComponent

var SPEED = 100
var spawnPos

func _ready():
	if name.begins_with("@"):
		multiplayer_synchronizer.set_multiplayer_authority(1)
	else:
		multiplayer_synchronizer.set_multiplayer_authority(str(name).to_int())
	
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		camera.make_current()
		spawnPos = position
		
	
func SetUpPlayer(name: String):
	$"Display Name Label".text = name
	

func _physics_process(delta):
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		var directionX = Input.get_axis("Left", "Right")
		if directionX and stateMachine.canMoveCheck():
			velocity.x = (directionX * SPEED)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if directionX == 1 and stateMachine.canMoveCheck():
			sprite.flip_h = false
		elif directionX == -1 and stateMachine.canMoveCheck():
			sprite.flip_h = true
			
		var directionY = Input.get_axis("Up", "Down")
		if directionY and stateMachine.canMoveCheck():
			velocity.y = (directionY * SPEED)
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

		move_and_slide()
		
		projectile_rotation.look_at(get_viewport().get_mouse_position())

func _process(delta):
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
		if Input.is_physical_key_pressed(KEY_0):
			healthComponent.TakeDamage(10)

@rpc("any_peer","call_local")
func fire():
	
	var projectile = proj.instantiate()
	projectile.position = global_position
	projectile.rotation_degrees = projectile_rotation.rotation_degrees
	get_tree().root.add_child(projectile, true)



