# Enemy.gd
extends Area2D
class_name Enemy

signal isDamaged

@onready var speed = 25


@onready var health = 0
@onready var healthBar = $HealthBar
@export var maxHealth = 100
@onready var currentHealth = maxHealth
var DAMAGE_AMOUNT = 10

func _ready():
	health = maxHealth
	healthBar._init_health(health)
	var position = 0
	
	
func _physics_process(delta):
	position += (get_node("../Student").position - position)/speed


# If Enemy touches the student
func _on_area_entered(area):
	if area.is_in_group("student"):
		queue_free()
		
	# $MHealthBar.update()
		# Game over logic here 
	# Enemy will disappear here
	
#Die function
func die():
	queue_free()
