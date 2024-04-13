extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -900.0

@onready var Spr = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var left:bool

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("jump"):
		if velocity.y < 100 and velocity.y < 0:
			velocity.y = move_toward(velocity.y, velocity.y * .6, SPEED)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#Animations
	
	if Input.is_action_pressed("move_left"):
		Spr.flip_h = true
		if is_on_floor():
			Spr.play("Move")
		else:
			Spr.play("Falling")
		$CollisionShape2D.position = Vector2(-13.5,-4)
	
	elif Input.is_action_pressed("move_right"):
		Spr.flip_h = false
		if is_on_floor():
			Spr.play("Move")
		$CollisionShape2D.position = Vector2(13.5,-4)
	
	if Input.is_action_pressed("jump"):
		Spr.play("Jump")
	
	if velocity.y < 0:
		Spr.play("Falling")
	
	if velocity.x == 0 and velocity.y == 0:
		Spr.play("Idol")
	
	move_and_slide()

func wave(t:bool):
	if t:#left
		$"Dash-left".visible = true
		await get_tree().create_timer(.1).timeout
		$"Dash-left".visible = false
	else:
		$"Dash-right".visible = true
		await get_tree().create_timer(.1).timeout
		$"Dash-right".visible = false
