# Student.gd
extends Area2D
class_name Student

signal isDamaged
signal MHPdepleated

@onready var health
@onready var healthBar = $MHealthBar
@export var maxHealth = 100
@onready var currentHealth = maxHealth
var DAMAGE_AMOUNT = 50

func _ready():
	health = maxHealth
	healthBar._init_health(health)
	$AnimatedSprite2D.play("Idol")



# If Enemy touches the student
func _on_area_entered(area):
	if area.name.contains("enemy"):
		currentHealth -= DAMAGE_AMOUNT
		area.queue_free()
		healthBar._set_health(currentHealth)
		if area != null:
			isDamaged.emit()
	

func SqInteract():
	currentHealth += 20
	healthBar._set_health(currentHealth)

func checkHealth():
	if currentHealth <= 0:
		get_tree().change_scene_to_file("res://EndScreen.tscn")
