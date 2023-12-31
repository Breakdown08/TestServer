GDPC                @                                                                         T   res://.godot/exported/133200997/export-0db2d386c3a60fa12e665737a8266d7c-player.scn  �      K      �	�W��hM,7��D^�    T   res://.godot/exported/133200997/export-73010d7d11a63b36042ee0ee3baaed9c-server.scn  @            �������䔵d�    `   res://.godot/exported/133200997/export-b9779682b91c7b2da4387f54b09b659d-static_body_polygon.scn P
      �      L�l�~��̢�^�%    \   res://.godot/exported/133200997/export-c1186c905694af49abc5dc8848cec595-rigid_body_2d.scn   p      �      ��.�|C�㊓�}�X�    ,   res://.godot/global_script_class_cache.cfg  P1             ��Р�8���8~$}P�       res://.godot/uid_cache.bin  p1      (       ��R^T��H���u����    ,   res://assets/custom_polygon/rigid_body_2d.gd        p      E��5��:[Kj��(M�    4   res://assets/custom_polygon/rigid_body_2d.tscn.remap�/      j       �;U�  �I�M�nH�1    4   res://assets/custom_polygon/static_body_polygon.gd   	      &      ���}xG���(0�T    <   res://assets/custom_polygon/static_body_polygon.tscn.remap   0      p       H(ţ�{���~�s�>        res://assets/player/Player.cs                 h�)ژ��@��ح\��@        res://assets/player/YawEnum.cs  0             h�)ژ��@��ح\��@        res://assets/player/player.gd   0      �      ۶Fʭ���m�&1�    (   res://assets/player/player.tscn.remap   p0      c       ��]�*��2ZbdXp��       res://project.binary�1      �      
]7l�^�T+ߋ��        res://scenes/server.tscn.remap  �0      c       S<ز��@֝ӻF�P       res://singletones/events.gd �      �      "�����b���        res://singletones/server.gd `      ,      �Oֆ[��3�T��Һ�.    (   res://singletones/server/ClientRPC.cs   p             h�)ژ��@��ح\��@    (   res://singletones/server/Extentions.cs  �             h�)ژ��@��ح\��@    $   res://singletones/server/Server.cs  �             h�)ژ��@��ح\��@    0   res://singletones/server/services/BaseService.csP             h�)ژ��@��ح\��@    0   res://singletones/server/services/PeerService.cs`             h�)ژ��@��ح\��@    extends RigidBody2D

@onready var polygon = $Polygon2D

func _ready():
	# Store the polygon's global position so we can reset its position after moving its parent
	var polygon_global_position = polygon.global_position
	# Move the rigidbody to the center of the polygon, taking into account
	# any offset the Polygon2D node may have relevant to the rigidbody
	var polygon_center = get_polygon_center()
	global_position += polygon_center + polygon.position
	# Move the polygon node to its original position
	polygon.global_position = polygon_global_position
	
	var collision_shape = CollisionPolygon2D.new()
	collision_shape.polygon = offset_polygon_points(polygon_center)
	add_child(collision_shape)

# Offset the points of the polygon by the center of the polygon
func offset_polygon_points(center: Vector2):
	var adjusted_points = []
	for point in polygon.polygon:
		# Moving the collision shape itself doesn't seem to work as well as offsetting the polygon points
		# for putting the collision shape in the right position after moving the rigidbody.
		# Therefore, to have the collision shape appear where drawn, subtract the polygon center from each point
		# to move the point by the amount the rigidbody was moved relative to the original Polygon2D's position.
		adjusted_points.append(point - center)
	return adjusted_points

# A simple weighted average of all points of the polygon to find the center
func get_polygon_center():
	var center_weight = polygon.polygon.size()
	var center = Vector2(0, 0)
	
	for point in polygon.polygon:
		center.x += point.x / center_weight
		center.y += point.y / center_weight
	
	return center
	return center
RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script -   res://assets/custom_polygon/rigid_body_2d.gd ��������      local://PackedScene_t33lw $         PackedScene          	         names "         RigidBody2D    script 
   Polygon2D    	   variants                       node_count             nodes        ��������        ����                            ����              conn_count              conns               node_paths              editable_instances              version             RSRC;���extends Polygon2D

func _ready():
	var collision_shape = CollisionPolygon2D.new()
	# Polygon2D.polygon contains a list of all vertices on the drawn polygon
	# so just copy those points over to the new collision shape
	collision_shape.polygon = polygon
	$StaticBody2D.add_child(collision_shape)
�Y/���n&RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script 3   res://assets/custom_polygon/static_body_polygon.gd ��������      local://PackedScene_4ingk *         PackedScene          	         names "         StaticBodyPolygon    script 
   Polygon2D    StaticBody2D    	   variants                       node_count             nodes        ��������       ����                            ����              conn_count              conns               node_paths              editable_instances              version             RSRCVf#��=�
qf���.A[�extends RigidBody2D

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
����m�4E�����RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       Script    res://assets/player/Player.cs ��������   
   local://2 a      
   local://1 �         local://PackedScene_63spl �         RectangleShape2D             RectangleShape2D       
   F��@��'@         PackedScene          	         names "         Player 	   position    gravity_scale    script    RigidBody2D    Head    shape    CollisionShape2D    Body 	   modulate    scale    	   variants       
     D  �B                 
         ��               �?          �?
     �@  �@               node_count             nodes     %   ��������       ����                                        ����                                 ����   	      
                      conn_count              conns               node_paths              editable_instances              version             RSRCC%s�K
�˞�S;7C��0��RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       PackedScene 5   res://assets/custom_polygon/static_body_polygon.tscn ��������   PackedScene     res://assets/player/player.tscn ��������      local://PackedScene_ck2gb m         PackedScene          	         names "         Map    Node2D    Border1 	   position 	   rotation    polygon    Border2    Player    	   variants                 
     �D �D   �I�%   	     �B  �C  �B  �C  kD ��C �kD  uC @UD  tC �TD ��C  \C  �C  XC  uC  �B  yC
      @  �B         
    @D  tC      node_count             nodes     (   ��������       ����                ���                                        ���                                  ���                         conn_count              conns               node_paths              editable_instances              version             RSRC
Hk�A�.�3:kS�L
�Oe7�m���t�Ds
�ـ�F&ҌO��E��
/���h���*���
�D#T��:Sk �a�extends Node


signal engine_thrusted(action) #тяга двигателя активна
signal engine_stopped(action) #тяга двигателя отключена
signal engine_reverse_thrusted(action) #обратная тяга двигателя активна
signal engine_reverse_stopped(action) #обратная двигателя отключена
signal engine_yaw_left_enabled(action) #активно рысканье влево
signal engine_yaw_left_disabled(action) #брошено рысканье влево
signal engine_yaw_right_enabled(action) #активно рысканье вправо
signal engine_yaw_right_disabled(action) #брошено рысканье вправо
�extends Node

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
	var server = ENetMultiplayerPeer.new()
	var err =  server.create_server(port)
	if err != OK:
		print("Unable to start server")
		log_to_debug("Unable to start server")
		return
	get_tree().network_peer = server
	get_tree().connect("peer_connected", Callable(self, "_player_connected"))
	get_tree().connect("peer_disconnected", Callable(self, "_player_disconnected"))
	print("Server created")
	log_to_debug("Server created")
	

func _player_connected(id):
	print("Player connected: ", id)
	log_to_debug("Player connected: " + str(id))
	
	
@rpc("any_peer") func instance_space_body(space_body_class):
	var id = get_tree().get_remote_sender_id()
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
	var err = server.listen(port, PackedStringArray(), true)
	if err != OK:
		print("Unable to start server")
		log_to_debug("Unable to start server")
		set_process(false)
		return
	get_tree().network_peer = server
	get_tree().connect("peer_connected", Callable(self, "_player_connected"))
	get_tree().connect("peer_disconnected", Callable(self, "_player_disconnected"))
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
	


@rpc("any_peer") func update_transform(position, rotation, velocity):
	var player_id = get_tree().get_remote_sender_id()
	rpc_unreliable("update_player_transform", player_id, position, rotation, velocity)


@rpc("any_peer") func calculate_collisions(collision_info):
	var player_id = get_tree().get_remote_sender_id()
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


@rpc("any_peer") func player_damaged(hp):
	var player_id = get_tree().get_remote_sender_id()
	rpc("player_damaged", player_id, hp)
	
	
@rpc("any_peer") func respawn_player(id):
	rpc("respawn_player", id, choose_spawn_location())


@rpc("any_peer") func test_call():
	test_counter += 1
	rpc("test_call", test_counter)


@rpc("any_peer") func player_killed(killer):
	var player_id = get_tree().get_remote_sender_id()
	kills[killer] += 1
	if kills[killer] > highest:
		highest = kills[killer]
		rpc("update_highest", highest)
	rpc_id(int(killer), "update_kills", kills[killer])
	rpc("player_killed", player_id)


@rpc("any_peer") func destroy_bullet(bullet_name):
	rpc("delete_obj", bullet_name)	
	
	
#remote func export_database():
#	var player_id = get_tree().get_rpc_sender_id()
#	rpc_id(player_id, "import_database", database.export_database())
#	log_to_debug(database.export_database())
	
	
func _process(delta):
	if is_websocket_connetcion:
		server.poll()
��a][remap]

path="res://.godot/exported/133200997/export-c1186c905694af49abc5dc8848cec595-rigid_body_2d.scn"
�l����[remap]

path="res://.godot/exported/133200997/export-b9779682b91c7b2da4387f54b09b659d-static_body_polygon.scn"
[remap]

path="res://.godot/exported/133200997/export-0db2d386c3a60fa12e665737a8266d7c-player.scn"
׳B��	�m�`[remap]

path="res://.godot/exported/133200997/export-73010d7d11a63b36042ee0ee3baaed9c-server.scn"
|2��	oq6I���list=Array[Dictionary]([])
}���   L.d�k�Od   res://scenes/server.tscn�,`���ECFG      application/config/name      
   TestServer     application/run/main_scene          res://scenes/server.tscn   application/config/features   "         4.1    C#     autoload/Server,      #   *res://singletones/server/Server.cs "   debug/shapes/collision/shape_color        �?  �?  �?��?   display/window/stretch/mode         viewport   display/window/stretch/aspect      
   keep_width     dotnet/project/assembly_name      
   TestServer     global/Visible             global/Visible Collisiobn             global/Visible Collision          +   gui/common/drop_mouse_on_gui_input_disabled            mono/project/assembly_name      
   TestServer  )   physics/common/enable_pause_aware_picking         �"��Ȇt�