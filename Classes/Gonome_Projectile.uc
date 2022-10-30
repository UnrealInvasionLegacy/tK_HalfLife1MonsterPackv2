class Gonome_Projectile extends HalfLife_Projectile;

simulated function PostBeginPlay()
{
    local Rotator R;

    Super.PostBeginPlay();

    Velocity = Vector(Rotation);
    Velocity *= (Speed + 100);
    R = Rotation;
    R.Roll = Rand(65536);
    SetRotation(R);
}

defaultproperties
{
     ExplodeClass=Class'tk_HalfLife1MonsterPackv2.Gonome_Projectile_Explode'
     HitSound=SoundGroup'WeaponSounds.BioRifle.BioRifleGoo2'
     Speed=900.000000
     MaxSpeed=1200.000000
     Damage=20.000000
     DamageRadius=0.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'tk_HalfLife1MonsterPackv2.DamType_Gonome_Projectile'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'XEffects.GibOrganicTorso'
     AmbientSound=None
     DrawScale=0.250000
     bFixedRotationDir=True
     RotationRate=(Roll=80000)
}
