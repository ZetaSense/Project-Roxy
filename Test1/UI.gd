extends CanvasLayer

var time:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/Label.text = get_node("../../").name

func _process(_delta):
	$MarginContainer2/HBoxContainer/Label2.text = str(time)
	if int(60 - $Timer.time_left) >= 10:
		$MarginContainer2/HBoxContainer/Label4.text = str(int(60 - $Timer.time_left))
	else:
		$MarginContainer2/HBoxContainer/Label4.text = "0" + str(int(60 - $Timer.time_left))
	$MarginContainer/VBoxContainer/Label2.text = "Score: " + str(GameSingleton.score)

func _on_timer_timeout():
	time+=1
