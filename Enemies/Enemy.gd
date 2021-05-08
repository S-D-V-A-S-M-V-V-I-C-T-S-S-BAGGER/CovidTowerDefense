extends Node2D
class_name Enemy


enum State { CREATED, SPAWNED, ALIVE, DEAD }

export(NodePath) var path


# ##
# # STATS
# ##
# Attributes that describe the state of the entity
export(int) var base_health = 100
export(int) var base_immunity = 0.5
export(int) var base_speed = 300.0

var immunity: float
var health: int
var speed = 1.0

var effects = []
var state = State.CREATED


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if path:
		get_node("Path").curve = get_node(path).curve
		
	on_spawn()
	state = State.SPAWNED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# First, process the dead state
	if state == State.DEAD:
		return
	elif health <= 0:
		die()
		return
	
	# Then initialize the base case
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
	
	# Check if the entity is still alive
	if health <= 0:
		die()
		return
	
	# Otherwise, continue
	var cur_speed = base_speed * speed;
	$Path/MovingPoint/AnimatedSprite.speed_scale = speed
	get_node("Path/MovingPoint").offset += speed * delta


func die():
	# Cannot die multiple times
	if state == State.DEAD:
		return
	
	$Path/MovingPoint/Area2D/Collision.disabled = true
	$Path/MovingPoint/AnimatedSprite.speed_scale = 1.0
	$Path/MovingPoint/AnimatedSprite.play("death")
	on_die()
	state = State.DEAD


func damage(amount: int):
	health -= amount
	if health <= 0:
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
		effects.append(effect)



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

# Process damage, opportunity to increase / decrease the amount
func on_damaged(amount: int) -> int:
	return amount

# Process the applied effect, opportunity to cancel the effect
func on_effect(effect) -> bool:
	return true

