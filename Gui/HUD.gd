extends MarginContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export (NodePath) var spawner_path
var spawn_time_label : Label
var spawner : Node

export (NodePath) var enemy_parent_path
var enemy_counter_label : Label
var enemy_parent : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_time_label = $SideBar/SpawnTimer/HBox/TimerLabel
	spawner = get_node(spawner_path)
	enemy_counter_label = $SideBar/EnemyCounter/HBox/EnemyCounterValueLabel
	enemy_parent = get_node(enemy_parent_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if spawner:
		var spawner_time = 	stepify(spawner.spawn_timer, 1)
		spawn_time_label.text = str(spawner_time)
	
	if enemy_parent:
		var enemy_count = enemy_parent.get_child_count()
		enemy_counter_label.text = str(enemy_count)
