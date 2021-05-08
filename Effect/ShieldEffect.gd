extends Effect
class_name ShieldEffect


var initial: float
var shield: float


func _init(enemy: Enemy, shield: float).(enemy, -1) -> void:
	self.shield = shield
	self.initial = shield


func name() -> String:
	return "ShieldEffect"


func on_damage(amount: float) -> float:
	# If the shield is not big enough, then decrease the damage and remove the
	# shield
	if amount > shield:
		state = State.EXPIRED
		return amount - shield
	
	# Otherwise, deteriorate the shield and block the damage
	shield -= amount
	return 0.0


func on_effect(effect: Effect) -> bool:
	if effect.name() != "ShieldEffect":
		return true
	
	shield += effect.shield
	return false
