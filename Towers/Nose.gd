extends Node2D

#TODO: NOSE

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export(int) var max_snot_count = 3
export(float) var time_between_snots = 3.0


export var snot_count := 1
export var snot_timer := 0.0


func initialize(tower_position, path_position):
	position = tower_position
	$Snot.position = path_position
	var particle_origin = $Particles2D.position
	
	var emitter_material : ParticlesMaterial = $Particles2D.process_material
	
	# Point sneeze to path
	var direction : Vector2 = particle_origin.direction_to(path_position)
	emitter_material.direction = Vector3(direction.x, direction.y, 0.0)
	
	# Scale sneeze power with distance
	var distance_ratio = particle_origin.distance_to(path_position) / 32.0
	emitter_material.initial_velocity *= distance_ratio
	emitter_material.damping *= distance_ratio
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_snot_animation()
	$Particles2D.set_one_shot(true)
	$Particles2D.set_emitting(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if snot_timer < time_between_snots:
		# Increase the timer
		snot_timer += delta
	else:
		if snot_count < max_snot_count:
			# Add a snot
			snot_count += 1
			set_snot_animation()
			$Particles2D.set_emitting(true)
			snot_timer = 0.0


func set_snot_animation():
	match snot_count:
		0:
			$Snot/AnimatedSprite.play("zero")
		1:
			$Snot/AnimatedSprite.play("one")
		2:
			$Snot/AnimatedSprite.play("two")
		3:
			$Snot/AnimatedSprite.play("three")
		_:
			$Snot/AnimatedSprite.play("many")


func _on_Snot_area_entered(area: Area2D) -> void:
	if snot_count > 0:
		snot_count -= 1
		set_snot_animation()
		var enemy = get_node(area.get_path()).get_parent().get_parent().get_parent()
		enemy.add_effect(SlowEffect.new(enemy, 5, 0.5))
