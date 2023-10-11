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

		Dictionary<long, Player> playerList = new Dictionary<long, Player>();

		private void OnEngineThrustChanged(long idPeer)
		{
			
		}

		public void CreatePlayer(long idPeer)
		{
			//playerList.Add(idPeer, new PolygonRigidBody2D());
		}

        public void RemovePlayer(long idPeer)
        {
			playerList.Remove(idPeer);
        }

        public override void _Init()
		{
			EventBus.Instance.EngineThrust += OnEngineThrustChanged;
			Server._multiplayer.PeerConnected += CreatePlayer;
			Server._multiplayer.PeerDisconnected += RemovePlayer;
		}
	}
}





//server. = (PackedScene)GD.Load("res://assets/player/player.tscn");
//player = (Player)GetTree().Root.GetNode("/root/Map/Player");
