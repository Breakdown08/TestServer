extends Node

var port = 5005
var spawn_points = [Vector2(100, 60), Vector2(510, 320), Vector2(950, 515)]
var spawn_points_clone = spawn_points.duplicate()
var taken_spawn_points = []
var obj_idx = 0
var kills = {}
var highest = 0
var test_counter = 0
var players_classes = {}
var server
var is_websocket_connetcion = false
#onready var database = $Database


func log_to_debug(data):
	pass
	#$Control/DebugOutput.text += '\n' + str(data)


func _ready():
#	with_multiplayerapi()
	with_websocket()


func with_multiplayerapi():
	var server = NetworkedMultiplayerENet.new()
	var err =  server.create_server(port)
	if err != OK:
		print("Unable to start server")
		log_to_debug("Unable to start server")
		return
	get_tree().network_peer = server
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	print("Server created")
	log_to_debug("Server created")
	

func _player_connected(id):
	print("Player connected: ", id)
	log_to_debug("Player connected: " + str(id))
	
	
remote func instance_space_body(space_body_class):
	var id = get_tree().get_rpc_sender_id()
	players_classes[str(id)] = str(space_body_class)
	rpc_id(0, "instance_player", id, choose_spawn_location(), players_classes)
	kills[str(id)] = 0


func _player_disconnected(id):
	print("Player disconnected: ", id)
	log_to_debug("Player disconnected: " + str(id))
	kills.erase(id)
	players_classes.erase(id)
	rpc_id(0, "delete_obj", id)


func with_websocket():
	is_websocket_connetcion = true
	server = WebSocketServer.new()
	var err = server.listen(port, PoolStringArray(), true)
	if err != OK:
		print("Unable to start server")
		log_to_debug("Unable to start server")
		set_process(false)
		return
	get_tree().network_peer = server
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	print("Server created")
	log_to_debug("Server created")


func choose_spawn_location():
	randomize()
	var point = randi()%spawn_points.size()
	var loc = spawn_points[point]
	taken_spawn_points.append(loc)
	spawn_points.remove(point)
	if spawn_points.size() <= 0:
		spawn_points = spawn_points_clone.duplicate()
		taken_spawn_points.clear()
	return loc
	


remote func update_transform(position, rotation, velocity):
	var player_id = get_tree().get_rpc_sender_id()
	rpc_unreliable("update_player_transform", player_id, position, rotation, velocity)


remote func calculate_collisions(collision_info):
	var player_id = get_tree().get_rpc_sender_id()
	log_to_debug("player: " + str(player_id))
#	log_to_debug("canMove calculate_collisions: " + str(collision_info["canMove"]))
#	print("Player ramming")
	var new_velocity = null
#
	# Рассчитываем относительную скорость
	var relative_velocity = collision_info["other_velocity"] - collision_info["self_velocity"]
	
	var impuls_point = collision_info["collision_points"].normalized() * collision_info["self_velocity"]
	
	# Рассчитываем скорость после столкновения
	var impulse = (collision_info["other_mass"] * (relative_velocity.dot(impuls_point))) / (collision_info["self_mass"] + collision_info["other_mass"]) * impuls_point

#	print("Data: " + str(collision_info["other_velocity.x"] + collision_info["other_velocity.y"]))
#	log_to_debug("result*: " + str(impulse))
	log_to_debug("result velocity: " + str(collision_info["other_velocity.x"] + collision_info["other_velocity.y"]))
#	if abs(collision_info["other_velocity.x"] + collision_info["other_velocity.y"]) > 0.1:
##		new_velocity = collision_info["collision_points"].reflect(collision_info["self_velocity"]) * collision_info["bounce_coefficient"]
##		rpc_unreliable("update_position_on_velocity", player_id, collision_info["self_global_position"], new_velocity)
#		new_velocity = impuls_point.reflect(impulse.normalized()) * collision_info["bounce_coefficient"]
#		log_to_debug("result bolshe: ")
#		rpc_unreliable("update_player_transform_collision", player_id, -new_velocity)
	if abs(collision_info["other_velocity.x"] + collision_info["other_velocity.y"]) <= 1.0:
		new_velocity = impuls_point.reflect(impulse.normalized()) * collision_info["bounce_coefficient"]
		log_to_debug("result: " + str(new_velocity))
		rpc_unreliable("update_player_transform_collision", player_id, -new_velocity)


remote func player_damaged(hp):
	var player_id = get_tree().get_rpc_sender_id()
	rpc("player_damaged", player_id, hp)
	
	
remote func respawn_player(id):
	rpc("respawn_player", id, choose_spawn_location())


remote func test_call():
	test_counter += 1
	rpc("test_call", test_counter)


remote func player_killed(killer):
	var player_id = get_tree().get_rpc_sender_id()
	kills[killer] += 1
	if kills[killer] > highest:
		highest = kills[killer]
		rpc("update_highest", highest)
	rpc_id(int(killer), "update_kills", kills[killer])
	rpc("player_killed", player_id)


remote func destroy_bullet(bullet_name):
	rpc("delete_obj", bullet_name)	
	
	
#remote func export_database():
#	var player_id = get_tree().get_rpc_sender_id()
#	rpc_id(player_id, "import_database", database.export_database())
#	log_to_debug(database.export_database())
	
	
func _process(delta):
	if is_websocket_connetcion:
		server.poll()
