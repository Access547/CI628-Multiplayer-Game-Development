extends State
class_name GolemE

func Enter():
	if $"../../GolemEHitbox/ETimer".is_stopped():
		$"../../GolemEHitbox/ETimer".start()
		$"../../GolemEHitbox/ECollisonBox".disabled = false
		character.stompsLeft = 5
		sprite.play("Walk")

