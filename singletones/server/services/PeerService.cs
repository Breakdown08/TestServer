using Godot;
using System;
using System.Runtime.CompilerServices;
using TestServer.assets.player;
using TestServer.Server;
using TestServer.singletones;
using TestServer.singletones.server;

namespace TestServer.Server
{
	public partial class Server: Node
	{
		[Rpc]
		public void RPCInput(params object[] args)
		{
			GD.Print("RPC IS WORKING!");
			GD.Print(PeerService.Instance.peerServiceVariable);
		}
	}

	public class PeerService : BaseService<PeerService>
	{
		public string peerServiceVariable = "SOME_DATA";

        public PeerService(Server server) : base(server) { }

        private void OnPeerConnected(long id)
		{
			GD.Print("Peer connected: ", id);
		}

		private void OnPeerDisconnected(long id)
		{
			GD.Print("Peer disconnected: ", id);
		}

		private void OnPacketReceived(long id, byte[] packet)
		{

		}

		public override void _Init()
		{
			Server._multiplayer.PeerConnected += OnPeerConnected;
			Server._multiplayer.PeerDisconnected += OnPeerDisconnected;
			Server._multiplayer.PeerPacket += OnPacketReceived;
		}
	}
}





//server. = (PackedScene)GD.Load("res://assets/player/player.tscn");
//player = (Player)GetTree().Root.GetNode("/root/Map/Player");
