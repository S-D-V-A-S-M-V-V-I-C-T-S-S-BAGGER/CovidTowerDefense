extends ColorRect

export (PackedScene) var level1_scene
export (PackedScene) var level2_scene

func _on_Level1Button_pressed() -> void:
	get_tree().change_scene_to(level1_scene)


func _on_Level2Button_pressed() -> void:
	get_tree().change_scene_to(level2_scene)
