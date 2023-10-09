using Godot;
using System;
using TestServer.assets.player;
using TestServer.Server;
using TestServer.singletones;

namespace TestServer.Server
{
	public partial class PeerService : BaseService
	{
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

        public void TestRemoteMethod(int id)
		{
			
		}

		public override void _Init()
		{
			Server._multiplayer.PeerConnected += OnPeerConnected;
            Server._multiplayer.PeerDisconnected += OnPeerDisconnected;
            Server._multiplayer.PeerPacket += OnPacketReceived;
            //server. = (PackedScene)GD.Load("res://assets/player/player.tscn");
            //player = (Player)GetTree().Root.GetNode("/root/Map/Player");
        }
    }
}
