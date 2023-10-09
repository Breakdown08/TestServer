using Godot;
using System;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace TestServer.Server
{
	public abstract class BaseService : Node
	{
		private Server _server;
		public Server server 
		{ 
		   get { return _server; }
		   set { _server = value; } 
		}

		public virtual void _Init() { }

		private void GetRPCMethods()
		{
			Type type = GetType();
			MethodInfo[] methods = type.GetMethods()
				.Where(method => method.IsDefined(typeof(RemoteAttribute), false))
				.ToArray();
			foreach (MethodInfo method in methods)
			{
				GD.Print(method.Name);
			}
		}

		public override void _Ready()
		{ 
			GetRPCMethods();
			_Init();
		}
	}


}

