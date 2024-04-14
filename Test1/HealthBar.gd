extends ProgressBar

@onready var enemy = get_parent()
@onready var timer = $Timer
@onready var damage_bar = $DamageBar

var health = 0 : set = _set_health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
		
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health
		
	
func _init_health(_health):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = enemy.currentHealth * 100 / enemy.maxHealth


func _on_timer_timeout():
	damage_bar.value = health