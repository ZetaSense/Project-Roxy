extends Node2D

const WALK_SPEED = 75
const GRAVITY = 600
const JUMP_VELOCITY = -400

@export var health = 1
@onready var player = get.node("/root/World/Students")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player:
		#Get direction (Vector2) from current enemy's position to player's postition
		var direction = (player.position - postion).normalized()
		if not is_on_floor():
			direction.y += GRAVITY
		
		move_and_slide(direction - WALK_SPEED)
		
		for i in get_slide_count():
			var collection = get_slide_collision(i)
			if collsion.collider.name == "Students":
				print("dead")

