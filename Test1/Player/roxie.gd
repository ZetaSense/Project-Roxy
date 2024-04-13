extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -900.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var left:bool

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_pressed("move_left") and !$Sprite2D.flip_h:
		$Sprite2D.flip_h = true
		if velocity.x < -250:
			wave(false)
	elif Input.is_action_pressed("move_right") and $Sprite2D.flip_h:
		$Sprite2D.flip_h = false
		if velocity.x > 250:
			wave(true)

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
