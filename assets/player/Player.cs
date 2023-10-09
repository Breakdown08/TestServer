using Godot;
using System;
using TestServer.assets.player;

public partial class Player : RigidBody2D
{
	[Export]
	float engineSpeed = 200;
	[Export]
	float rotationSpeed = 700;

	int engineThrust = 0;
	int engineYaw = (int)YawEnum.IDLE;


	public override void _Ready()
	{

	}

	public void TurnToSide(YawEnum side)
	{
		engineYaw = (int)side;
	}

	public void HandlePlayerActionMovement(float delta)
	{
		if (engineYaw == (int)YawEnum.LEFT)
		{
			ApplyTorqueImpulse(-rotationSpeed * delta);
		}
		if (engineYaw == (int)YawEnum.RIGHT)
		{
			ApplyTorqueImpulse(rotationSpeed * delta);
		}
	}

	public override void _Process(float delta)
	{
		HandlePlayerActionMovement(delta);
	}
}
