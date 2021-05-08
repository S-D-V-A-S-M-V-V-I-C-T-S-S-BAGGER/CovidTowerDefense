extends Effect
class_name SlowEffect


var amount: float


func _init(enemy: Enemy, duration: float, amount: float).(enemy, duration) -> void:
	self.amount = amount


func tick(delta: float):
	self.enemy.speed_modifier *= (1.0 - amount)
