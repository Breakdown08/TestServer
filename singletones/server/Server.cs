using Godot;
using System.Collections.Generic;
using System.Net;
using System.Numerics;
using System.Reflection;
using TestServer.assets.player;
using TestServer.singletones;
namespace TestServer.Server
{
	public partial class Server : Node
	{
		public const int PORT = 5005;
		WebSocketServer server;

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
			service.server = this;
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
		}

		public override void _Process(float delta)
		{
			server.Poll();
		}
	}
}
