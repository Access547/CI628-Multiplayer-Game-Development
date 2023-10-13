extends State
class_name CharacterStunnedState


@export var stunComponent: StunComponent

var stun_time
var stun_immune_time

func Enter():
	stun_time = stunComponent.stunTime
	

func Update(delta):
	if stun_time:
		stun_time -= 1
		if stun_time <= 0:
			transitioned.emit(self, "CharacterIdleState")

