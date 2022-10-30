class BullSquid_Projectile extends HalfLife_Projectile;

var() Sound SpitHitSounds[3];

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

	HitSound = SpitHitSounds[Rand(3)];
}

defaultproperties
{
     SpitHitSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_spithit1'
     SpitHitSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_spithit1'
     SpitHitSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_spithit1'
     TrailClass=Class'tk_HalfLife1MonsterPackv2.BullSquid_Projectile_Trail'
     ExplodeClass=Class'tk_HalfLife1MonsterPackv2.BullSquid_Projectile_Explode'
     Speed=900.000000
     MaxSpeed=1200.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'tk_HalfLife1MonsterPackv2.DamType_BullSquid_Projectile'
     AmbientSound=None
}
