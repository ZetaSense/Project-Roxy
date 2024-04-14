extends Control

@export var scene2:bool

func _on_button_pressed():
	if !scene2:
		get_tree().change_scene_to_file("res://Area2.tscn")
	else:
		get_tree().change_scene_to_file("res://Area3.tscn")
