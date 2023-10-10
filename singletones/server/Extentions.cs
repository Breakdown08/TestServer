using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using TestServer.Server;

namespace TestServer.singletones.server
{
	public static class Extentions
	{
		public static T GetField<T>(this Dictionary<string, BaseService> storage, string service, string name) 
		{
			return storage[service].GetField<T>(name);
		}

		public static T GetField<T>(this BaseService obj, string name)
		{
			Type type = obj.GetType();
			FieldInfo fieldInfo = type.GetField(name, BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance);

			if (fieldInfo != null)
			{
				object value = fieldInfo.GetValue(obj);
				if (value is T)
				{
					return (T)value;
				}
				else
				{
					throw new InvalidCastException($"Cannot cast field value to type {typeof(T)}");
				}
			}
			else
			{
				throw new ArgumentException($"Field '{name}' not found in type '{type.FullName}'");
			}
		}
	}
}
