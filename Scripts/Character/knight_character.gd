extends CharacterBody2D

@onready var stateMachine = $CharacterStateMachine
@onready var multiplayer_synchronizer = $MultiplayerSynchronizer
@onready var sprite = $Sprite
@onready var proj = preload("res://Scenes/Attacks/test_proj.tscn")


var SPEED = 100



func _ready():
	if name.begins_with("@"):
		multiplayer_synchronizer.set_multiplayer_authority(1)
	else:
		multiplayer_synchronizer.set_multiplayer_authority(str(name).to_int())
	
	

func _physics_process(delta):
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		var directionX = Input.get_axis("Left", "Right")
		if directionX and stateMachine.canMoveCheck():
			velocity.x = (directionX * SPEED)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if directionX == 1:
			sprite.flip_h = false
		elif directionX == -1:
			sprite.flip_h = true
			
		var directionY = Input.get_axis("Up", "Down")
		if directionY and stateMachine.canMoveCheck():
			velocity.y = (directionY * SPEED)
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

		move_and_slide()

func _process(delta):
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		if Input.is_action_just_pressed("AbilityL"):
			spawnProj.rpc()
		if Input.is_action_just_pressed("AbilityR"):
			stateMachine.currentState.transitioned.emit(stateMachine.currentState, "KnightR")

@rpc("any_peer", "call_local")
func spawnProj():
	if multiplayer_synchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		var projectile = proj.instantiate()
		projectile.position = get_local_mouse_position()
		get_parent().add_child(projectile, true)



func _on_sprite_animation_finished():
	if sprite.animation == "Block":
		stateMachine.currentState.transitioned.emit(stateMachine.currentState, "CharacterIdleState")
