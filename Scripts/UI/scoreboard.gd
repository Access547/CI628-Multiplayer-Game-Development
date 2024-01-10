extends VBoxContainer


var scoreCard = preload("res://Scenes/UI/score_card.tscn")

var classNames = ["Knight", "Golem"]

@export var isVisible = false

signal show
signal hide

func _ready():
	connect("show", MakeScoreBoard)
	connect("hide", ClearScoreBoard)


func MakeScoreBoard():
	for i in GameManager.players:
		var currentScoreCard = scoreCard.instantiate()
		add_child(currentScoreCard)
		currentScoreCard.playerLabel.set_text(GameManager.players[i].name)
		currentScoreCard.classLabel.set_text(classNames[GameManager.players[i].class])
		currentScoreCard.kdLabel.set_text(str("", "/", ""))


func ClearScoreBoard():
	for child in get_children():
		child.queue_free()
