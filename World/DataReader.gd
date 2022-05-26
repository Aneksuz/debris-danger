extends Node

var folder_path

onready var current_world = get_parent() 


# Called when the node enters the scene tree for the first time.
func _ready():
	folder_path = "res://Data/Worlds/" + String(current_world.world) + "/Levels/"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_level() -> Dictionary:
	update_folder_path()
	
	var file_path = folder_path + "Level_" + String(current_world.current_level) + ".json"
	var file = File.new()
	
	assert(file.file_exists(file_path))
	file.open(file_path, file.READ)
	var level = parse_json(file.get_as_text())
	assert(level.size() > 0)
	return level

func update_folder_path() -> void:
	folder_path = "res://Data/Worlds/" + String(current_world.world) + "/Levels/"
