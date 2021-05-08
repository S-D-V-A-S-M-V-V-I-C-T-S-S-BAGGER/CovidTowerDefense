extends ColorRect

export (PackedScene) var level1_scene

func _on_Level1Button_pressed() -> void:
	get_tree().change_scene_to(level1_scene)
