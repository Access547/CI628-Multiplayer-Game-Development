extends Label

@export var character: StateMachine

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_text(str("State: ", character.currentState.name))
