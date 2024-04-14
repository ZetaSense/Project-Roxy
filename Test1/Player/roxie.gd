extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -900.0
var control:bool = true
@onready var SitSpr = $IdolSprites
@onready var WalkSpr = $WalkigSprites

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var left:bool

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and control:
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("jump") and control:
		if velocity.y < 100 and velocity.y < 0:
			velocity.y = move_toward(velocity.y, velocity.y * .6, SPEED)
	
	if Input.is_action_pressed("Bark") and control:
		Bark()
	
	if Input.is_action_pressed("Spin") and control:
		Spin()
	
	if Input.is_action_pressed("Eyes") and control:
		PuppyEyes()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction and control:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#Animations
	
	if Input.is_action_pressed("move_left") and control:
		SitSpr.visible = false
		WalkSpr.visible = true
		SitSpr.flip_h = true
		WalkSpr.flip_h = true
		if is_on_floor():
			WalkSpr.play("Run")
		else:
			WalkSpr.play("Falling")
		$CollisionShape2D.position = Vector2(-13.5,-4)
	
	elif Input.is_action_pressed("move_right") and control:
		SitSpr.visible = false
		WalkSpr.visible = true
		SitSpr.flip_h = false
		WalkSpr.flip_h = false
		if is_on_floor():
			WalkSpr.play("Run")
		else:
			WalkSpr.play("Falling")
		$CollisionShape2D.position = Vector2(13.5,-4)
	
	if Input.is_action_pressed("jump"):
		WalkSpr.play("Jump")
	
	if velocity.y < 0:
		WalkSpr.play("Falling")
	
	if velocity.x == 0 and velocity.y == 0 and control:
		SitSpr.visible = true
		WalkSpr.visible = false
		SitSpr.play("Idol")
	
	move_and_slide()

func Bark():
	control = false
	SitSpr.visible = true
	WalkSpr.visible = false
	SitSpr.play("Bark")
	await SitSpr.animation_finished
	control = true

func Spin():
	control = false
	SitSpr.visible = false
	WalkSpr.visible = true
	WalkSpr.play("Spin")
	await WalkSpr.animation_finished
	control = true

func PuppyEyes():
	control = false
	SitSpr.visible = true
	WalkSpr.visible = false
	if SitSpr.flip_h:
		$AnimationPlayer.play("SparkleR")
	else:
		$AnimationPlayer.play("SparkleL")
	await $AnimationPlayer.animation_finished
	control = true

func wave(t:bool):
	if t:#left
		$"Dash-left".visible = true
		await get_tree().create_timer(.1).timeout
		$"Dash-left".visible = false
	else:
		$"Dash-right".visible = true
		await get_tree().create_timer(.1).timeout
		$"Dash-right".visible = false
