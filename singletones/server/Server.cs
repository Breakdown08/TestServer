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
		public Dictionary<string, BaseService> unreliableStorage = new Dictionary<string, BaseService>();
		public Dictionary<string, BaseService> reliableStorage = new Dictionary<string, BaseService>();
		public Dictionary<string, BaseService> serviceStorage = new Dictionary<string, BaseService>();
		WebSocketMultiplayerPeer peer;
		public SceneMultiplayer _multiplayer = new SceneMultiplayer();

		private void RegisterService(BaseService service)
		{
			service.Server = this;
			serviceStorage.Add(nameof(service), service);
			AddChild(service);
		}

		private void CollectServices()
		{
			RegisterService(new PeerService());
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
			CollectServices();
			Create();
			foreach (var item in serviceStorage)
			{
				GD.Print(item);
			}
			
		}
	}
}
