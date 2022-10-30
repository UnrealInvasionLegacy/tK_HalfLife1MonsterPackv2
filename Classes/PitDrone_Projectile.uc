class PitDrone_Projectile extends HalfLife_Projectile;

defaultproperties
{
     ExplodeClass=Class'tk_HalfLife1MonsterPackv2.PitDrone_Projectile_Explosion'
     HitSound=Sound'DistantBooms.Generic.DistantTank'
     Speed=850.000000
     MaxSpeed=1000.000000
     DamageRadius=20.000000
     MomentumTransfer=1000.000000
     MyDamageType=Class'tk_HalfLife1MonsterPackv2.DamType_PitDrone_Projectile'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'tk_HalfLife1MonsterPackv2.Statics.Pit_Drone_Spike'
     AmbientSound=None
     DrawScale=1.000000
     DrawScale3D=(X=1.500000,Y=2.000000,Z=2.000000)
     PrePivot=(X=4.000000)
     CollisionRadius=4.000000
     CollisionHeight=3.000000
}
