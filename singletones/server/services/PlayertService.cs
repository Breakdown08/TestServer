using Godot;
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using TestServer.assets.player;
using TestServer.Server;
using TestServer.singletones;
using TestServer.singletones.server;

namespace TestServer.Server
{
	public partial class Server: Node
	{

	}

	public class PlayerService : BaseService<PlayerService>
	{
		public PlayerService(Server server) : base(server) { }

		public Dictionary<int, Player> PlayerList { get; set;}

		public void OnEngineThrustChanged(int idPeer)
		{
			
		}

		public override void _Init()
		{
			EventBus.Instance.EngineThrust += OnEngineThrustChanged;
		}
	}
}





//server. = (PackedScene)GD.Load("res://assets/player/player.tscn");
//player = (Player)GetTree().Root.GetNode("/root/Map/Player");
