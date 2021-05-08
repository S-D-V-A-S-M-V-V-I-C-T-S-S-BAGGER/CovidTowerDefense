extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_toggled(button_pressed):
	if button_pressed:
		get_parent().select_position(self)
		$AnimatedSprite.play("press")
		$PathPosition/Sprite.visible = true
	else:
		get_parent().deselect_position()
		$AnimatedSprite.play("unpress")
		$PathPosition/Sprite.visible = false

func unpress():
	$Button.pressed = false
	$AnimatedSprite.play("unpress")
	$PathPosition/Sprite.visible = false

func disable():
	unpress()
	$Button.disabled = true
	queue_free()
