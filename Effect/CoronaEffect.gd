extends Effect
class_name CoronaEffect


var damage: float
var infectious: float

var particle_scene: PackedScene = load("res://Enemies/CoronaParticle.tscn")


func _init(enemy: Enemy, duration: float, damage: float, infectious: float).(enemy, duration) -> void:
	self.damage = damage
	self.infectious = infectious


func name() -> String:
	return "CoronaEffect"


func tick(delta: float):
	enemy.immunity *= 0.5
	enemy.damage(damage * delta)


func on_damage(amount: float) -> float:
	var spread = randf() < self.infectious
	if spread:
		var particle = particle_scene.instance()
		var enemy_position = enemy.get_node("Path/MovingPoint").position
		particle.position = enemy_position
		var enemy_parent = enemy.get_parent()
		enemy_parent.add_child(particle)
	
	return amount


func on_effect(effect: Effect) -> bool:
	if effect.name() != "CoronaEffect":
		return true
	
	# Calculate the balance between the two corona effects. RNG will prefer
	# selection of the better one
	var balance = (effect.damage / self.damage) * (effect.infectious / self.infectious)
	var replace = 2 * randf() < balance
	if not replace:
		active = 0.0
		duration = effect.duration
		return false
	
	# Then apply the new corona effect and set this one to expired
	state = State.EXPIRED
	return true
