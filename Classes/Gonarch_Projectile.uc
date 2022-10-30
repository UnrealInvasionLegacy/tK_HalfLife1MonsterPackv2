class Gonarch_Projectile extends HalfLife_Projectile;

var() Actor Seeking;
var() vector InitialDir;
var() int LockTime;

replication
{
    reliable if(Role==ROLE_Authority)
    Seeking, InitialDir;
}

simulated function PostBeginPlay()
{
    if ( bDeleteMe || IsInState('Dying') )
    {
        return;
    }

    Super.PostBeginPlay();

    Velocity = Vector(Rotation);
    Velocity *= Speed;
    Velocity.Z += 800;
    SetTimer(0.1, true);
}

simulated function Timer()
{
    local vector ForceDir;
    local float VelMag;

    if ( InitialDir == vect(0,0,0) )
    {
        InitialDir = Normal(Velocity);
    }

    LockTime++;
    Acceleration = vect(0,0,0);
    Super.Timer();
    if( Seeking != None && LockTime < 7)
    {
        ForceDir = Normal(Seeking.Location + vect(0,0,20) - Location);

        VelMag = 1.02 * VSize(Velocity);

        ForceDir = Normal(ForceDir * 1.1 * VelMag + Velocity);
        Velocity = VelMag * ForceDir;
        SetRotation(rotator(Velocity));
    }
    else
    {
        Velocity = Vector(Rotation);
        Velocity *= Speed;
        SetTimer(0.0, false);
    }
}

defaultproperties
{
     TrailClass=Class'tk_HalfLife1MonsterPackv2.Gonarch_Projectile_Trail'
     ExplodeClass=Class'tk_HalfLife1MonsterPackv2.Gonarch_Projectile_Explode'
     HitSound=Sound'WeaponSounds.BaseImpactAndExplosions.BExplosion3'
     Speed=900.000000
     MaxSpeed=1000.000000
     Damage=45.000000
     MomentumTransfer=12000.000000
     MyDamageType=Class'tk_HalfLife1MonsterPackv2.DamType_Gonarch_Projectile'
}
