using System.Reflection;

namespace TestServer.singletones
{
	public static class ClientRPC
	{
		public static string MySuperCustomMethod() { return MethodBase.GetCurrentMethod().Name; }
	}
}
