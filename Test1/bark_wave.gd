extends Area2D

@export var Speed = 0
@export var left:bool = false
var Active:bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Active:
		if left:
			position.x = position.x - Speed
		else:
			position.x = position.x + Speed

func Initalize(dir:bool):
	Speed = 7
	left = dir
	Active = true
	$Sprite2D.flip_h = !dir

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.name.contains("enemy") and area.has_method("TakeDamage"):
		area.TakeDamage(3)
	queue_free()
