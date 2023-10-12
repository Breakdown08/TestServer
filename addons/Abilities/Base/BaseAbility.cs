using Godot;
using System;

public partial class BaseAbility : Node
{
	[Export]
	public RigidBody2D body;
	private const int NESTING_LEVEL = 3;
	public bool IsActive { get; protected set; } = false;
	public bool IsRegistered { get; private set; } = false;

	public delegate void Performed();
	public Performed performed;
	public virtual void _ProcessControl() { }
	public virtual void _Perform() { }
	public void Execute()
	{
		if (IsActive && IsRegistered)
		{
			_Perform();
			performed?.Invoke();
		}
	}
}
