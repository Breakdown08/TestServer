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

		public virtual void _Init() { }

		public override void _Ready()
		{ 
			_Init();
		}
	}


}

