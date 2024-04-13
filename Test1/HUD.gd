# HUD.gd
extends CanvasLayer

@onready var healthBar := $TextureProgress

func _ready():
	update_health_bar()

func update_health_bar():
	var hb = get_parent().get_node("KinematicBody2D")
	healthBar.value = hb.health
