# Student.gd
extends Area2D
class_name Student

signal isDamaged
signal MHPdepleated

@onready var health
@onready var healthBar = $MHealthBar
@export var maxHealth = 100
@onready var currentHealth = maxHealth
var DAMAGE_AMOUNT = 10

func _ready():
	health = maxHealth
	healthBar._init_health(health)
	$AnimatedSprite2D.play("Idol")



# If Enemy touches the student
func _on_area_entered(area):
	if area.name.contains("enemy"):
		currentHealth -= DAMAGE_AMOUNT
		healthBar._set_health(currentHealth)
		await get_tree().create_timer(.3).timeout
		area.queue_free()
		isDamaged.emit()
		if currentHealth <= 0:
			currentHealth = 0
			MHPdepleated.emit()
	# $MHealthBar.update()
		# Game over logic here 
	# Enemy will disappear here
	
