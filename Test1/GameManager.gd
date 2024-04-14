extends Node


@export var Scene:PackedScene
@export var Area: int = 1
var rng = RandomNumberGenerator.new()
var spawning:bool = false
var Number:int = 0
var NeedToPass: int
var time:float = 5
var time2:float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	match Area:
		1:
			NeedToPass = 3
		2:
			NeedToPass = 6
		_:
			NeedToPass = 9


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time = delta + time
	time2 = delta + time2
	if time > 10.0:
		SpawnEnemy()
		time = 0
	
	if time2 > 30.0:
		GameSingleton.diff += 1
		time2 = 0
		if GameSingleton.diff == NeedToPass:
			match Area:
				1: 
					get_tree().change_scene_to_file("res://Inbetween1.tscn")
				2: 
					get_tree().change_scene_to_file("res://Inbetween2.tscn")
				_: 
					if !GameSingleton.Inf:
						get_tree().change_scene_to_file("res://winning_screen.tscn")
					else:
						get_tree().change_scene_to_file("res://Inbetween1.tscn")
	

func SpawnEnemy():
	if !spawning:
		spawning = true
		var q = 0
		while q < GameSingleton.diff:
			var r = rng.randi_range(1,3)
			var r2 = rng.randi_range(1,2)
			var EPos:Vector2 = get_node("spawn" + str(r2)).global_position
			var EnemySpawned = Scene.instantiate()
			match r:
				3:
					EnemySpawned.position = EPos
				_:
					EnemySpawned.position = Vector2(EPos.x, EPos.y - rng.randi_range(1,375))
			EnemySpawned.assign(r)
			EnemySpawned.name = "enemy" + str(Number)
			Number+=1
			get_node("../").add_child.call_deferred(EnemySpawned)
			q+=1
			await get_tree().create_timer(.2).timeout
		spawning = false



func _on_student_mh_pdepleated():
	if GameSingleton.score > GameSingleton.Hiscore:
		GameSingleton.Hiscore = GameSingleton.score
	get_tree().change_scene_to_file("res://EndScreen.tscn")
