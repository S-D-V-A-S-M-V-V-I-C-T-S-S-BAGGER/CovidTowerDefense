extends Node
class_name Effect


enum State {CREATED, ACTIVE, EXPIRED}


var enemy: Enemy

var active = 0.0
var duration
var state = State.CREATED


func _init(enemy: Enemy, duration: float) -> void:
	self.duration = duration
	self.enemy = enemy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if state == State.CREATED:
		# Process on_add hook
		on_add()
		state = State.ACTIVE
	elif state == State.EXPIRED:
		# Don't do anything on expired events
		return
	
	active += delta
	if is_expired():
		# Process on_expire hook
		on_expire()
		state = State.EXPIRED
		return
	
	tick(delta)


func is_expired() -> bool:
	return state == State.EXPIRED || (duration >= 0.0 && active >= duration)



# ##
# # ABSTRACT FUNCTIONS
# ##
# To be implemented by children:

func tick(delta: float):
	pass

func on_add():
	pass

func on_expire():
	pass
