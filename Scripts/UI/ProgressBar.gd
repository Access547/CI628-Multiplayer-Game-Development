extends ProgressBar


@export var healthComponent: HealthComponent

func _process(delta):
	value = (float(healthComponent.health) / float(healthComponent.maxHealth) * 100)
