extends RayCast


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var shadow_distance = Vector3.ZERO
var initial_position = Vector3(0, -0.45, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		var collision_point = get_collision_point()
		var playerPosWorldSpace = global_transform.origin
		var distanceBetween = sqrt(pow(playerPosWorldSpace.y - collision_point.y, 2))
		
		print(playerPosWorldSpace)
		
		var shadowPos = initial_position
		shadowPos.y = distanceBetween - 0.45
		
		# print(shadowPos)

		translation = shadowPos
