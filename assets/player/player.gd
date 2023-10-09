extends RigidBody2D

@export var engine_speed: float = 200
@export var rotation_speed: float = 700

var engine_thrust = 0
var engine_yaw = 0


func _ready():
	pass


func handle_player_action_movement(delta):
	if engine_yaw == -1:
		apply_torque_impulse(-rotation_speed * delta)
	if engine_yaw == 1:
		apply_torque_impulse(rotation_speed * delta)


func _physics_process(delta):
	handle_player_action_movement(delta)
