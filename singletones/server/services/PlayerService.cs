using Godot;
using System;
using TestServer.assets.player;
using TestServer.Server;
using TestServer.singletones;

namespace TestServer.Server
{
	public partial class PlayerService : BaseService
	{
		private void OnPlayerConnected(int id)
		{
			GD.Print("Player connected: ", id);
		}

		private void OnPlayerDisconnected(int id)
		{
			GD.Print("Player disconnected: ", id);
		}

		
		public void TestRemoteMethod(int id)
		{
			
		}

		public override void _Init()
		{
			//server.player
			//server. = (PackedScene)GD.Load("res://assets/player/player.tscn");
			GetTree().Connect("network_peer_connected", new Callable(this, nameof(OnPlayerConnected)));
			GetTree().Connect("network_peer_disconnected", new Callable(this, nameof(OnPlayerDisconnected)));
			//player = (Player)GetTree().Root.GetNode("/root/Map/Player");
		}
	}
}
