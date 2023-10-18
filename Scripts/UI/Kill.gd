extends HBoxContainer

func Create(Killer: String, Victim: String):
	$Killer.text = Killer
	$Victim.text = Victim



func _on_timer_timeout():
	queue_free()
