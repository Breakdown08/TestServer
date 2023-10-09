using Godot;
using System;
using System.Collections.Generic;
using System.Net;
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
		WebSocketServer server;
		public Dictionary<string, BaseService> storageRP = new Dictionary<string, BaseService>();

		private void RunWebsocket()
		{
			server = new WebSocketServer();
			Godot.Error error = server.Listen(PORT, null, true);
			if (error != Error.Ok)
			{
				GD.Print(error.ToString());
				SetProcess(false);
				return;
			}
			GetTree().NetworkPeer = server;
			GD.Print("Server created");
		}

		private void RegisterService(BaseService service)
		{
			service.Server = this;
			AddChild(service);
		}

		private void CollectServices()
		{
			RegisterService(new PlayerService());
		}
		
		public override void _Ready()
		{
			CollectServices();
			RunWebsocket();
			RPCInput(nameof(PlayerService.TestRemoteMethod));
		}

		public override void _Process(float delta)
		{
			server.Poll();
		}

		[Remote]
		public void RPCInput(string methodName, params object[] args)
		{
			this.FindRPCMethod(methodName);
		}
	}
}
