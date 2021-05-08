extends Enemy
class_name VaccineEnemy


export(float) var vaccine_interval = 0.5
export(int) var vaccine_units = 4

var in_range : Array = []
var last_cast = 0.0


func _process(delta: float) -> void:
	._process(delta)
	
	if state == State.DEAD || state == State.FINISHED:
		return
	
	last_cast += delta
	while delta >= vaccine_interval:
		delta -= vaccine_interval
		do_vaccinate()


func do_vaccinate():
	var amount = randi() % (vaccine_units) + vaccine_units - vaccine_units / 2
	for i in amount:
		var enemy = in_range[randi() % in_range.size()]
		enemy.add_effect(VaccineEffect.new(enemy))


func _on_Healing_area_entered(area: Area2D) -> void:
	var enemy : Enemy = area.owner
	if !in_range.has(enemy):
		in_range.append(enemy)


func _on_Healing_area_exited(area: Area2D) -> void:
	var enemy : Enemy = area.owner
	in_range.erase(enemy)
