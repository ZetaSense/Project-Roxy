extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameSingleton.score > GameSingleton.Hiscore:
		GameSingleton.Hiscore = GameSingleton.score
	
	$MarginContainer/HBoxContainer/Score.text = GameSingleton.score
	$MarginContainer/HBoxContainer/Score2.text = GameSingleton.Hiscore
