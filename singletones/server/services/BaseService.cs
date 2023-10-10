using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace TestServer.Server
{
	public abstract class BaseService<T> where T: BaseService<T>
	{
		public static T Instance { get; private set; }
		public Server Server { get; private set; }
		public virtual void _Init() { }
		public BaseService(Server server) 
		{
			Server = server;
            Instance = (T)this;
			_Init();
		}
	}
}

