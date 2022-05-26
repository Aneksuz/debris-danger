extends Spatial


# Variables
export (int) var width;
export (int) var height;
export (float) var x_start;
export (float) var y_start;
export (float) var z_start;
export (float) var separation;

var current_level
var possible_patterns

#Obstacle Array
var possible_obstacles = [
preload ("res://Obstacles/Obstacle_Debris_1.tscn"),
preload ("res://Obstacles/Obstacle_Powerup_Helm.tscn"),
];

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#pass	

func spawn_obstacles():
	var random_pattern = possible_patterns[rand_range(0, possible_patterns.size())]
	#random_pattern = [0, 0, 0, 0, 1, 1, 1, 1]
	var iteration = 0
	
	for i in height:
		for j in width:
			if(random_pattern[iteration] != 0):
				
				var obstacle = possible_obstacles[random_pattern[iteration] - 1].instance()
				
				add_child(obstacle)
				obstacle.translation = Vector3(x_start - j * separation , y_start - i, z_start)
				obstacle.speed = current_level.Object_Speed
			
			iteration = iteration + 1

func _on_SpawnTimer_timeout():
	spawn_obstacles()
	
func _on_World_on_level_up(level, level_data, pattern_data):
	possible_patterns = pattern_data
	current_level = level_data.duplicate()
	$SpawnTimer.wait_time = level_data.Object_Pulse
	
	
