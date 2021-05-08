extends Effect
class_name ShieldEffect


var shield: float


func _init(enemy: Enemy, duration: float, shield: float).(enemy, duration) -> void:
	self.shield = shield


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
	if effect.get_class() != "ShieldEffect":
		return true
	
	shield += effect.shield
	return false
