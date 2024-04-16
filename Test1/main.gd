extends Control

var rng = RandomNumberGenerator.new()
@onready var Sit = $TitkeCard/RoxieSit
@onready var Stand = $TitkeCard/RoxieStand

func _ready():
	var choose = rng.randi_range(1,2)
	if choose == 1:
		Sit.visible = false
		Stand.visible = true
		Stand.play("Spin")
	else:
		Sit.visible = true
		Stand.visible = false
		Sit.play("Bark")

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Controls.tscn")


func _on_quit_pressed():
	get_tree().quit()

func _on_check_button_toggled(toggled_on):
	GameSingleton.Inf = toggled_on


