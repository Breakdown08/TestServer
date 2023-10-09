using Godot;
using System;
using TestServer.assets.player;
using TestServer.Server;

namespace TestServer.Server
{
	public class PlayerService : BaseService
	{
		private void OnPlayerConnected(int id)
		{
			GD.Print("Player connected: ", id);
		}

		private void OnPlayerDisconnected(int id)
		{
			GD.Print("Player disconnected: ", id);
		}

		[Remote]
		public void TestRemoteMethod(int id)
		{

		}

		public override void _Init()
		{
			//server.player
			//server. = (PackedScene)GD.Load("res://assets/player/player.tscn");
			GetTree().Connect("network_peer_connected", this, nameof(OnPlayerConnected));
			GetTree().Connect("network_peer_disconnected", this, nameof(OnPlayerDisconnected));
			//player = (Player)GetTree().Root.GetNode("/root/Map/Player");
		}
	}
}
