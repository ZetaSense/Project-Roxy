extends ProgressBar

var student : Student

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = student.currentHealth * 100 / student.maxHealth