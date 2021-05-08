extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var time_between_spawns := 2.0
export(NodePath) var path

var spawn_timer := 0.0

export (NodePath) var wave_parent_path
export (NodePath) var enemy_parent_path

var level : Level

var enemies_parent : Node

var waves : Array

var enemies : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = owner
	waves = get_node(wave_parent_path).get_children()
	enemies_parent = get_node(enemy_parent_path)
	load_wave()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer -= delta

	if spawn_timer <= 0:
		spawn()
		spawn_timer += time_between_spawns


func load_wave():
	var wave : Node = waves.pop_front()
	if wave:
		spawn_timer = wave.time_before_start
		time_between_spawns = wave.time_between_enemies
		enemies = wave.enemies
	else:
		done()


func done():
	pass


func spawn():
	var enemy_scene : PackedScene = enemies.pop_front()
	if enemy_scene:
		var enemy = enemy_scene.instance()
		enemy.get_node("Path").curve = get_node(path).curve
		enemies_parent.add_child(enemy)
		level.enemies_spawned += 1
	else:
		load_wave()
