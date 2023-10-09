extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	global_position.x += 1


func _on_timer_timeout():
	#queue_free()
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
