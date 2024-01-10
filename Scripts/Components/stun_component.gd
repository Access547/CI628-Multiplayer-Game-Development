extends Node
class_name StunComponent


var stun_time
var stunImmuneTime

@export var canBeStunned: bool = true


func Stun(time: int):
	if !(get_parent().stateMachine.currentState is CharacterRespawningState):
		stun_time = time
		stunImmuneTime = 300
		canBeStunned = false
		get_parent().stateMachine.currentState.transitioned.emit(get_parent().stateMachine.currentState, "CharacterStunnedState")
		
		
func _process(_delta):
	
	if get_parent().stateMachine.currentState != CharacterStunnedState:
		if stunImmuneTime:
			stunImmuneTime -= 1
	if stunImmuneTime:
		if stunImmuneTime <= 0:
			if !canBeStunned:
				canBeStunned = true
