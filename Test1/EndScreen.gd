extends Control

func _ready():
	$Container/AnimatedSprite2D.play("Sad :(")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
