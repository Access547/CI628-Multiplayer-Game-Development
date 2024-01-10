extends Label

@export var character: StateMachine

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	set_text(str(character.currentState.name))
