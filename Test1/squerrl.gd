extends Area2D

var Active:bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if Active:
		position.x += 30
	
	var arr = get_overlapping_areas()
	for i in arr:
		if i != null and i.has_method("SqInteract"):
			i.SqInteract()
	

func Activate():
	Active = true
	$AnimatedSprite2D.play("move")


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


