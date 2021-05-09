extends Effect
class_name VaccineEffect


func _init(enemy: Enemy).(enemy, -1) -> void:
	pass


func name() -> String:
	return "VaccineEffect"


func tick(delta: float):
	enemy.immunity = 1.0


func on_effect(effect: Effect) -> bool:
	return effect.name() != "CoronaEffect"

func is_priority() -> bool:
	return true
