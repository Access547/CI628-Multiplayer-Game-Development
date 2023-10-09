extends CharacterBody2D

@onready var stateMachine = $CharacterStateMachine
@onready var multiplayer_synchronizer = $MultiplayerSynchronizer

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
			
		var directionY = Input.get_axis("Up", "Down")
		if directionY and stateMachine.canMoveCheck():
			velocity.y = (directionY * SPEED)
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

		move_and_slide()
