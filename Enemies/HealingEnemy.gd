extends Enemy
class_name HealingEnemy


export(float) var heal = 10.0
export(float) var heal_interval = 0.5
export(int) var heal_units = 4

var last_cast = 0.0

var in_range : Array = []

func _process(delta: float) -> void:
	._process(delta)
	
	if state == State.DEAD || state == State.FINISHED:
		return
	
	last_cast += delta
	while delta >= 1.0:
		delta -= 1.0
		do_heal()


func do_heal():
	pass


func _on_Healing_area_entered(area: Area2D) -> void:
	var enemy : Enemy = area.owner
	if !in_range.has(enemy):
		in_range.append(enemy)


func _on_Healing_area_exited(area: Area2D) -> void:
	var enemy : Enemy = area.owner
	in_range.erase(enemy)
