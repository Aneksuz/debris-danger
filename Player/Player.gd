class_name Player
extends KinematicBody



export var move_speed = 1
export var jump_height : float
export var jump_peak : float
export var jump_descent : float

var hp = 2
var invincible = false
var velocity = Vector3.ZERO

onready var jump_velocity : float = (2.0 * jump_height) / jump_peak
onready var asc_gravity : float = (-2.0 * jump_height) / (jump_peak * jump_peak)
onready var desc_gravity : float = (-2.0 * jump_height) / (jump_descent * jump_descent)


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector)
	flip_sprite(input_vector)
	animation_toggle_invincible()
	jump()
	apply_gravity(delta)
	$AnimationTree.set("parameters/in_air_%d/current" % [hp], 1 - int(is_on_floor()))
	velocity = move_and_slide(velocity, Vector3.UP)	
	$AnimationTree.set("parameters/damage_state/current", hp)



func update_hp(value: int) -> void:
	if !invincible and value < 0:
		hp = hp + value
		$InvincibilityTimer.start()
		invincible = true
	elif value > 0 and hp < 2:
		hp = hp + value

func get_input_vector():
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("movement_right") - Input.get_action_strength("movement_left")
	input_vector.z = Input.get_action_strength("movement_backward") - Input.get_action_strength("movement_forward")
	
	return input_vector.normalized()


#Function to handle movement based on input
func apply_movement(input_vector):
	velocity.x = input_vector.x * move_speed
	velocity.z = input_vector.z * move_speed
	if velocity.x != 0 or velocity.z != 0:
		$AnimationTree.set("parameters/movement_%d/current" % [hp], 1)
	else:
		$AnimationTree.set("parameters/movement_%d/current" % [hp], 0)



#Function to gravity
func apply_gravity(delta):
	velocity.y += get_gravity() * delta


func get_gravity() -> float:
	if velocity.y > 0.0:
		$AnimationTree.set("parameters/is_falling_%d/current" % [hp], 0)
		return asc_gravity 
	else: 
		$AnimationTree.set("parameters/is_falling_%d/current" % [hp], 1)
		return desc_gravity
		


#Function to handle the jump action
func jump():
	if is_on_floor() and Input.is_action_pressed("movement_jump"):
		velocity.y = jump_velocity
		$AnimationTree.set("parameters/is_falling_%d/current" % [hp], 0)


func animation_toggle_invincible():
	if invincible:
		$Sprite3D.opacity = 0.5
	else:
		$Sprite3D.opacity = 1

#Function to apply a flip to the sprite depending on the direction the player is moving.
func flip_sprite(input_vector):
	if input_vector.x == -1:
		get_node("Sprite3D").flip_h = false
	if input_vector.x == 1:
		get_node("Sprite3D").flip_h = true


func _on_InvincibilityTimer_timeout():
	invincible = false


func _on_ObstacleHitboxArea_body_entered(body):
	if body.type == "OBSTACLE":
		update_hp(-1)
	if body.type == "HELM":
		update_hp(1)
