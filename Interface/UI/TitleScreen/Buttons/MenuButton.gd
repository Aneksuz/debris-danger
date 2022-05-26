extends Button

export (String) var transition_to

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_QuitButton_button_up():
	get_tree().paused = false
	get_tree().change_scene(transition_to)
	pass # Replace with function body.


func _on_MenuButton_focus_entered():
	$Contents/TextureRect.visible = true


func _on_MenuButton_focus_exited():
	$Contents/TextureRect.visible = false
