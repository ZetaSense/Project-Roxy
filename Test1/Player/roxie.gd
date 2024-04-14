extends CharacterBody2D


var SPEED = 600.0
var JUMP_VELOCITY = -950.0
var control:bool = true
var Stunned:bool = false



@onready var SitSpr = $IdolSprites
@onready var WalkSpr = $WalkigSprites

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var left:bool
@export var PLayIdol:bool = true
@export var Scene:PackedScene

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and control:
		jump()
	
	if Input.is_action_just_released("jump") and control:
		if velocity.y < 100 and velocity.y < 0:
			velocity.y = move_toward(velocity.y, velocity.y * .6, SPEED)
	
	if Input.is_action_pressed("Bark") and control:
		Bark()
	
	if Input.is_action_just_pressed("Debug") and control:
		Stun()
	
	if Input.is_action_pressed("Spin") and control and velocity.y == 0:
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
	
	if velocity.y != 0:
		WalkSpr.play("Falling")
	
	if Input.is_action_just_pressed("down"):
		Squish(true)
	elif Input.is_action_just_released("down"):
		Squish(false)
	
	if velocity.x == 0 and velocity.y == 0 and control and PLayIdol:
		SitSpr.visible = true
		WalkSpr.visible = false
		SitSpr.play("Idol")
	
	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY
	SitSpr.visible = false
	WalkSpr.visible = true
	WalkSpr.play("Falling")

func Bark():
	control = false
	SitSpr.visible = true
	WalkSpr.visible = false
	var BarkP = Scene.instantiate()
	SitSpr.play("Bark")
	await get_tree().create_timer(.25).timeout
	if $IdolSprites.flip_h:
		BarkP.global_position = $LeftRayCasts.global_position
	else:
		BarkP.global_position = $RightRayCasts.global_position
	get_node("../").add_child.call_deferred(BarkP)
	BarkP.Initalize($IdolSprites.flip_h)
	await SitSpr.animation_finished
	control = true

func Spin():
	control = false
	$Swipes.visible = true
	SitSpr.visible = false
	WalkSpr.visible = true
	WalkSpr.play("Spin")
	$TailWagAOE/CollisionShape2D.disabled = false
	var ToDamage = $TailWagAOE.get_overlapping_areas()
	for j in ToDamage:
		if j.get_collider().has_method("TakeDamage"):
			j.TakeDamage(1)
	await WalkSpr.animation_finished
	$Swipes.visible = false
	$TailWagAOE/CollisionShape2D.disabled = true
	control = true

func PuppyEyes():
	control = false
	SitSpr.visible = true
	WalkSpr.visible = false
	if SitSpr.flip_h:
		$AnimationPlayer.play("SparkleR")
		for i in $RightRayCasts.get_children():
			i.force_raycast_update()
			i.get_collider()
			if i.get_collider() != null:
				if i.get_collider().has_method("TakeDamage"):
					i.takeDamage(2)
	else:
		$AnimationPlayer.play("SparkleL")
		for i in $LeftRayCasts.get_children():
			i.force_raycast_update()
			i.get_collider()
			if i.get_collider() != null:
				if i.get_collider().has_method("TakeDamage"):
					i.takeDamage(2)
	
	await $AnimationPlayer.animation_finished
	control = true

func Squish(t:bool):
	PLayIdol = false
	SitSpr.visible = true
	WalkSpr.visible = false
	if t:
		SitSpr.play("Crouch")
	else:
		SitSpr.play("UnCrouch")
	await SitSpr.animation_finished
	if !t:
		PLayIdol = true

func Stun():
	if !Stunned:
		Stunned = true
		control = false
		SitSpr.visible = false
		WalkSpr.visible = true
		$AnimationPlayer.play("TakeHit")
		WalkSpr.play("Falling")
		velocity.y = -400
		await get_tree().create_timer(1).timeout
		Stunned = false
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
