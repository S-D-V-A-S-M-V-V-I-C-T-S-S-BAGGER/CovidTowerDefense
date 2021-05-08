extends VBoxContainer

export (PackedScene) var bat_tower
export (int) var bat_tower_cost = 10
export (PackedScene) var slow_tower
export (int) var slow_tower_cost = 10
export (PackedScene) var cell_tower
export (int) var cell_tower_cost = 10
export (PackedScene) var fastfood_tower
export (int) var fastfood_tower_cost = 10
export (PackedScene) var lidl_tower
export (int) var lidl_tower_cost = 10
export (PackedScene) var nerts_tower
export (int) var nerts_tower_cost = 10

var bank : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	bank = owner.get_node("SideBar/Bank")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func place_tower(tower_scene:PackedScene, cost:int) -> void:
	var selected_position = owner.get_node("TowerPositions").consume_position()
	if selected_position and bank.pay(cost):
		var tower = tower_scene.instance()
		var tower_position = selected_position.position
		var path_position = selected_position.get_node("PathPosition").position
		tower.initialize(tower_position, path_position)
		owner.owner.add_child(tower)
		selected_position.disable()


func _on_BatTower_pressed():
	place_tower(bat_tower, bat_tower_cost)


func _on_SlowTower_pressed():
	place_tower(slow_tower, slow_tower_cost)


func _on_CellTower_pressed():
	place_tower(cell_tower, cell_tower_cost)


func _on_FastfoodTower_pressed():
	place_tower(fastfood_tower, fastfood_tower_cost)


func _on_LidlTower_pressed():
	place_tower(lidl_tower, lidl_tower_cost)


func _on_NertsTower_pressed():
	place_tower(nerts_tower, nerts_tower_cost)
