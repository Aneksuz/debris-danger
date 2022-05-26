extends Spatial

signal on_level_up(level, level_data, possible_patterns)

export (int) var world;
export (int) var max_level;

var current_level = 1
var score = 0
var time = 0
var seconds = 0
var minutes = 0

var level_data = {}
var pattern_data = []

onready var player: KinematicBody = get_node("Player")
onready var hud: Control = get_node("HUD")
onready var data_reader: Node = get_node("DataReader")


# Called when the node enters the scene tree for the first time.
func _ready():
	update_data(data_reader.load_level())
	
	pass # Replace with function body.

func _process(delta):
	
	time += delta
	
	seconds  = fmod(time, 60)
	minutes = fmod(time, 60*60) / 60
	get_node("HUD/HBoxContainer/InfoLabels/TimeLabel").text = "%02d:%02d" % [minutes, seconds]
	
	if(player.hp <= 0): handle_gameover()

func level_up() -> void:
	current_level = current_level + 1
	update_data(data_reader.load_level())
	$LevelTimer.wait_time = level_data["Duration_In_Seconds"]
	emit_signal("on_level_up", current_level, level_data, pattern_data)
			
	

func _on_KillBox_body_entered(body):
	handle_gameover()
	#pass # Replace with function body.


func _on_Timer_timeout():
	
	level_up()
	if current_level >= max_level:
		get_node("LevelTimer").set_paused(true)
	pass # Replace with function body.


func update_data(dic : Dictionary):
	level_data = dic["Level"]
	pattern_data = dic["Patterns"]
	emit_signal("on_level_up", current_level, level_data, pattern_data)

func handle_gameover() -> void:
	$HUD/GameoverOverlay/GameoverMenu/TimeLabel.text = "%02d:%02d" % [minutes, seconds]
	hud.set_gameover(true)
	
