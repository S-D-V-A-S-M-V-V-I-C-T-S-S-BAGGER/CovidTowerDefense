extends Node2D
class_name Enemy


enum State { CREATED, SPAWNED, ALIVE, DEAD, FINISHED }


# ##
# # STATS
# ##
# Attributes that describe the state of the entity
export(float) var base_health = 100.0
export(float) var base_immunity = 0.5
export(float) var base_speed = 300.0

var immunity = 1.0
var health: float
var speed = 1.0

var effects = []
var shield = null
var state = State.CREATED

var level : Level


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	health = base_health
	
	on_spawn()
	state = State.SPAWNED


func initialize(curve : Curve2D, parent_level : Level) -> void:
	$Path.curve = curve

	level = parent_level

	level.enemies_spawned += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# First, process the dead state
	if state == State.DEAD || state == State.FINISHED:
		return
	elif health <= 0:
		die()
		return
	
	# Then initialize the base case
	immunity = 1.0
	speed = 1.0
	
	# Process all effects
	var expired = []
	for effect in effects:
		# Don't process expired effects
		if effect.is_expired():
			expired.append(effect)
			continue
		
		# Let the effect do its thing
		effect._process(delta)
	
	# Then remove all expired effects
	for effect in expired:
		effects.erase(effect)
		
		# Also delete the shield
		if effect == shield:
			shield = null
	
	# Check if the entity is still alive
	if health <= 0.0:
		die()
		return
	
	# Otherwise, continue
	var cur_speed = base_speed * speed;
	var movement: PathFollow2D = get_node("Path/MovingPoint")
	movement.offset += cur_speed * delta

	# Update animation speed
	$Path/MovingPoint/AnimatedSprite.speed_scale = speed

	# Check if we have reached the end of the path
	if movement.unit_offset >= 1.0:
		finish()
		return


func die():
	# Cannot die multiple times
	if state == State.DEAD:
		return
	
	level.enemies_killed += 1

	$Path/MovingPoint/Area2D/Collision.disabled = true
	$Path/MovingPoint/AnimatedSprite.speed_scale = 1.0
	$Path/MovingPoint/AnimatedSprite.play("death")
	on_die()
	state = State.DEAD


func finish():
	level.enemies_arrived += 1

	on_finish()
	state == State.FINISHED
	
	# Prepare for deletion
	$Path/MovingPoint/Area2D/Collision.disabled = true
	queue_free()



func damage(amount: float):
	amount = on_damage(amount)
	health -= amount
	if health <= 0.0:
		die()


func heal(amount: int):
	# Cannot resurrect entities
	if state == State.DEAD:
		return
	
	# Apply heal
	health += amount
	
	# Don't overheal
	if health >= base_health:
		health = base_health


func add_effect(effect):
	if not on_effect(effect):
		return
	
	# Save a reference to the shield effect for later use
	if effect.get_class() == "ShieldEffect":
		shield = effect
	
	if effect.is_priority():
		effects.insert(0, effect)
	else:
		effects.append(effect)


func get_health() -> float:
	return health


func get_shield() -> float:
	return shield.shield if shield != null else 0.0


func get_max_health() -> float:
	var cur_health = get_health() + get_shield()
	return base_health if cur_health < base_health else cur_health


func is_infected() -> bool:
	for e in effects:
		if e.get_class() == "CoronaEffect":
			return true
	
	return false


# ##
# # HOOKS
# ##
# To be implemented by children

# Maybe do something when this unit spawns?
func on_spawn():
	pass

# Maybe do something when this unit dies?
func on_die():
	pass

# Handle this entity finishing the course
func on_finish():
	pass

# Process damage, opportunity to increase / decrease the amount
func on_damage(amount: float) -> float:
	# Give effects a chance to modify damage
	for effect in effects:
		amount = effect.on_damage(amount)
	
	return amount

# Process the applied effect, opportunity to cancel the effect
func on_effect(effect) -> bool:
	# Give effects a chance to cancel other effects
	for e in effects:
		if not e.on_effect(effect):
			return false
	
	return true
