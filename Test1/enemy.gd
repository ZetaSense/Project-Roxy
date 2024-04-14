# Enemy.gd
extends Area2D
class_name Enemy

signal isDamaged

@onready var speed = 100


@onready var health = 0
@onready var healthBar = $HealthBar
@export var maxHealth = 100
@onready var currentHealth = maxHealth
var DAMAGE_AMOUNT = 10

@export var Type:int

func _ready():
	health = maxHealth
	healthBar._init_health(health)
	#position = Vector2(0,0)
	
	match Type:
		1:
			$Sprite2D.texture = load("res://Assets/Anger.png")
		2:
			$Sprite2D.texture = load("res://Assets/Anxiety.png")
		_:
			$Sprite2D.texture = load("res://Assets/Depression.png")
	
func _physics_process(_delta):
	position += (get_node("../Student").position - position)/speed

func TakeDamage(inp:int):
	die()

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
