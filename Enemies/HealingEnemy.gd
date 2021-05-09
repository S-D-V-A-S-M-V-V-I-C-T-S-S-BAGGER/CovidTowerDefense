extends Enemy
class_name HealingEnemy


export(float) var heal = 10.0
export(float) var heal_interval = 0.5
export(int) var heal_units = 4

var in_range : Array = []
var last_cast = 0.0


func _process(delta: float) -> void:
	._process(delta)
	
	if state == State.DEAD || state == State.FINISHED:
		return
	
	last_cast += delta
	while delta >= heal_interval:
		delta -= heal_interval
		do_heal()


func do_heal():
	var amount = randi() % (heal_units) + heal_units - heal_units / 2
	for i in amount:
		var enemy = in_range[randi() % in_range.size()]
		enemy.heal(heal)


func _on_Healing_area_entered(area: Area2D) -> void:
	var enemy = area.owner
	if !in_range.has(enemy):
		in_range.append(enemy)


func _on_Healing_area_exited(area: Area2D) -> void:
	var enemy = area.owner
	in_range.erase(enemy)


func on_die():
	$Path/MovingPoint/Healing/CollisionShape.disabled = false
