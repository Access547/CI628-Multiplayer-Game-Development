extends Area2D

var direction: Vector2

@export var projSpeed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(1,0).rotated(rotation)


func _physics_process(delta):
	global_position += direction.normalized() * projSpeed



func _on_timer_timeout():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("Player"):
		
		area.Damage(2)
		
		queue_free()
