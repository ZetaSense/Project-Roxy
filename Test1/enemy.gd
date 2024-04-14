# Enemy.gd
extends Area2D
class_name Enemy

signal isDamaged

@onready var speed = 100
@export var num:int
@export var Health = 30
@onready var health = 0
@onready var healthBar = $HealthBar
@export var maxHealth = 100
@onready var currentHealth = maxHealth
var DAMAGE_AMOUNT = 50
var woof:bool = true

@export var Type:int

func _ready():
	health = maxHealth
	healthBar._init_health(health)
	#position = Vector2(0,0)
	
func _physics_process(_delta):
	position += (get_node("../Student").position - position)/speed

func TakeDamage(inp:int):
	match inp:
		num:
			if woof:
				GameSingleton.score += 200
			else:
				GameSingleton.score += 120
			queue_free()
		1:
			woof = false
			match num:
				2:
					Health-=15
				3:
					Health-=10
		2:
			woof = false
			match num:
				1:
					Health-=10
				3:
					Health-=15
		3:
			woof = false
			match num:
				1:
					Health-=15
				2:
					Health-=10
	if Health <= 0:
		GameSingleton.score += 90
		queue_free()

func assign(i:int):
	num = i
	match i:
		1:
			$Sprite2D.texture = load("res://Assets/Depression.png")
		2:
			$Sprite2D.texture = load("res://Assets/Anxiety.png")
		3:
			$Sprite2D.texture = load("res://Assets/Anger.png")

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
