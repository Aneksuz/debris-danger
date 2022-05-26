extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var transition_path

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/CenterRow/Buttons/StartButton.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_button_pressed", [button.transition_to])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_button_pressed(transition_to):
	transition_path = transition_to
	$Fade.show()
	$Fade.fade_in()
			


func _on_Fade_fade_finished():
	if transition_path == "EXIT":
		get_tree().quit()
	else:
		get_tree().change_scene(transition_path)
