using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.WebSockets;
using System.Numerics;
using System.Reflection;
using TestServer.assets.player;
using TestServer.singletones;
using TestServer.singletones.server;

namespace TestServer.Server
{
	public partial class Server : Node
	{
		public const int PORT = 5005;
		WebSocketMultiplayerPeer peer;
		public SceneMultiplayer _multiplayer = new SceneMultiplayer();
		public List<object> services = new List<object> { };

		private void CollectServices()
		{
			services.Add(new PeerService(this));
		}

		private void Create()
		{
			WebSocketMultiplayerPeer peer = new WebSocketMultiplayerPeer();
			peer.CreateServer(PORT);
			_multiplayer.MultiplayerPeer = peer;
			GetTree().SetMultiplayer(_multiplayer);
			GD.Print("Server listening on ", PORT);
		}

		public override void _Ready()
		{
			Create();
			CollectServices();
		}
	}
}
