# Student.gd
extends Area2D
class_name Student

signal isDamaged

@onready var health
@onready var healthBar = $MHealthBar
@export var maxHealth = 100
@onready var currentHealth = maxHealth
var DAMAGE_AMOUNT = 10

func _ready():
	health = maxHealth
	healthBar._init_health(health)
	



# If Enemy touches the student
func _on_area_entered(area):
	if area.is_in_group("enemy"):
		currentHealth -= DAMAGE_AMOUNT
		healthBar._set_health(currentHealth)
		if currentHealth <= 0:
			currentHealth = 0
			isDamaged.emit()
	# $MHealthBar.update()
		# Game over logic here 
	# Enemy will disappear here
	
#Die function
func die():
	queue_free()
