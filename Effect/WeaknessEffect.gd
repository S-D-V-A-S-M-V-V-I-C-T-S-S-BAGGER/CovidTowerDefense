extends Effect
class_name WeaknessEffect


var damage_multiplier: float


func _init(enemy: Enemy, duration: float, damage_multiplier: float).(enemy, duration) -> void:
	self.damage_multiplier = damage_multiplier


func tick(delta: float):
	self.enemy.immunity *= 0.5


func on_damage(amount: float) -> float:
	return amount * damage_multiplier


func is_priority() -> bool:
	return true
