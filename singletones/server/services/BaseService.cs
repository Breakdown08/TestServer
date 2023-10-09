using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace TestServer.Server
{
	public abstract class BaseService : Node
	{
		private Server _server;
		public Server Server 
		{ 
		   get { return _server; }
		   set 
			{ 
				_server = value;
				foreach (MethodInfo method in this.GetReliableRPCMethods())
				{
					_server.reliableStorage.Add(method.Name, this);
				}
			}
		}

		private IEnumerable<MethodInfo> GetReliableRPCMethods()
		{
			Type type = GetType();
			MethodInfo[] methods = type.GetMethods()
				.Where(method => method.IsDefined(typeof(RemoteAttribute), false))
				.ToArray();
			return methods;
		}

        private IEnumerable<MethodInfo> GetUnreliableRPCMethods()
        {
            Type type = GetType();
            MethodInfo[] methods = type.GetMethods()
                .Where(method => method.IsDefined(typeof(RemoteAttribute), false))
                .ToArray();
            return methods;
        }

        public virtual void _Init() { }

		public override void _Ready()
		{ 
			_Init();
		}
	}


}

