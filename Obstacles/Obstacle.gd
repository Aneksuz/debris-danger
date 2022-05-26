extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"s
export (int) var speed;
export (String) var type;

var velocity = Vector3(0, 0, 1)

# Called when the node enters the scene tree for the first time.
#func _ready():
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	move_and_slide(velocity * speed, Vector3.UP)	


func _on_Timer_timeout():
	queue_free()


func _on_Area_body_entered(body):
	queue_free()
