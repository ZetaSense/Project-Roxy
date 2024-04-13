# Student.gd
extends Area2D


var health = 100
var DAMAGE_AMOUNT = 10

# If Enemy touches the student
func _on_area_entered(area):
	health -= DAMAGE_AMOUNT
	if health <= 0:
		health = 0
		# Game over logic here 
	# Enemy will disappear here
	update_health_ui()
	
#Die function
func die():
	queue_free()
