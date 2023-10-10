using Godot;
using System;

public partial class EventBus : Node
{

[Signal]
public delegate void EngineThrustEventHandler(int idPeer);
/*
signal engine_stopped(action) #тяга двигателя отключена
signal engine_reverse_thrusted(action) #обратная тяга двигателя активна
signal engine_reverse_stopped(action) #обратная двигателя отключена
signal engine_yaw_left_enabled(action) #активно рысканье влево
signal engine_yaw_left_disabled(action) #брошено рысканье влево
signal engine_yaw_right_enabled(action) #активно рысканье вправо
signal engine_yaw_right_disabled(action) #брошено рысканье вправо
*/

	public static EventBus Instance { get; private set;}
	public override void _Ready()
	{
		Instance = this;
	}
}
