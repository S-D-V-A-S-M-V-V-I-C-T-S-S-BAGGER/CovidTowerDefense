extends Effect
class_name CoronaEffect


var damage: float
var infectious: float


func _init(enemy: Enemy, duration: float, damage: float, infectious: float).(enemy, duration) -> void:
	self.damage = damage
	self.infectious = infectious


func tick(delta: float):
	enemy.immunity *= 0.5
	enemy.damage(damage * delta)


func on_damage(amount: float) -> float:
	var spread = randf() < self.infectious
	if spread:
		# TODO: Implement spreading corona
		push_warning("Corona spread effect not implemented yet (see CoronaEffect.gd:22)")
	
	return amount


func on_effect(effect: Effect) -> bool:
	if effect.get_class() != "CoronaEffect":
		return true
	
	# Calculate the balance between the two corona effects. RNG will prefer
	# selection of the better one
	var balance = (effect.damage / self.damage) * (effect.infectious / self.infectious)
	var replace = 2 * randf() < balance
	if not replace:
		return false
	
	# Then apply the new corona effect and set this one to expired
	state = State.EXPIRED
	return true
