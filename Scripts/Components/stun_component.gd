extends Node
class_name StunComponent


var stunTime
var stunImmuneTime




func Stun(time: int):
	if get_parent().stateMachine.currentState.canBeStunned:
		stunTime = time
		stunImmuneTime = 300
		get_parent().stateMachine.currentState.transitioned.emit(get_parent().stateMachine.currentState, "CharacterStunnedState")

