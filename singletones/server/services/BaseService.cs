using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace TestServer.Server
{
	public abstract partial class BaseService : Node
	{
		public Server Server { get; set; }
        public static BaseService Instance { get; private set; }
        public virtual void _Init() { }
		public override void _Ready()
		{
			Instance = this;
			_Init();
		}
	}


}

