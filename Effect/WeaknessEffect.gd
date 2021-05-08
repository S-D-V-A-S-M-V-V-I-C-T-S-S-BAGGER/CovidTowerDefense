extends Effect
class_name WeaknessEffect


var damage_multiplier: float


func _init(enemy: Enemy, duration: float, damage_multiplier: float).(enemy, duration) -> void:
	self.damage_multiplier = damage_multiplier


func on_damage(amount: float) -> float:
	return amount * damage_multiplier
