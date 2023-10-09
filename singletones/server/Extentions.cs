using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestServer.singletones.server
{
	public static class Extentions
	{
		public static void FindRPCMethod(this Server.Server server, string methodName)
		{
			//GD.Print("VISIBLE", server.storageRP[methodName]);
		}
	}
}
