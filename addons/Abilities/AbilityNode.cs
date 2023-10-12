#if TOOLS
using Godot;
using System;

[Tool]
public partial class AbilityNode : EditorPlugin
{
	public override void _EnterTree()
	{
		var script = GD.Load<Script>("res://addons/Abilities/Base/BaseAbility.cs");
		var texture = GD.Load<Texture2D>("res://addons/Abilities/ability.png");
		AddCustomType(nameof(BaseAbility), nameof(Node), script, texture);
	}

	public override void _ExitTree()
	{
		RemoveCustomType(nameof(BaseAbility));
	}
}
#endif
