extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var scene_tree = get_tree()
onready var pause_overlay: ColorRect = get_node("PausedOverlay")
onready var gameover_overay: ColorRect = get_node("GameoverOverlay")

var game_paused = false
var curr_level = 1
var paused: = false setget set_paused
var gameover: = false setget set_gameover

# Called when the node enters the scene tree for the first time.
func _ready():
	$PausedOverlay/PausedMenu/ResumeButton.connect("button_up", self, "_on_ResumeButton_button_up")
	$Fade.fade_out()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_paused(value: bool) -> void:
	paused = value
	if value: $PausedOverlay/PausedMenu/ResumeButton.grab_focus() 
	scene_tree.paused = value
	pause_overlay.visible = value

func set_gameover(value: bool) -> void:
	scene_tree.set_input_as_handled()
	gameover = value
	if value: $GameoverOverlay/GameoverMenu/GameoverButtons/RetryButton.grab_focus()
	scene_tree.paused = value
	gameover_overay.visible = value

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()


func _on_World_on_level_up(level, level_data, pattern_data):
	curr_level = level
	get_node("HBoxContainer/InfoLabels/LevelLabel").text = "Level: %d" % [curr_level]
	pass # Replace with function body.


func _on_ResumeButton_button_up():
	self.paused = false
	pass # Replace with function body.
