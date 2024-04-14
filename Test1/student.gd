# Student.gd
extends Area2D

class_name Student

signal healthChanged

@export var maxHealth = 100
@onready var currentHealth = maxHealth
var DAMAGE_AMOUNT = 10

# If Enemy touches the student
func _on_area_entered(area):
	if area.is_in_group("enemy"):
		currentHealth -= DAMAGE_AMOUNT
		if currentHealth <= 0:
			currentHealth = 0
	healthChanged.emit()
	$MHealthBar.update()
		# Game over logic here 
	# Enemy will disappear here
	
#Die function
func die():
	queue_free()
