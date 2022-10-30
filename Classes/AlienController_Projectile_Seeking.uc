class AlienController_Projectile_Seeking extends HalfLife_Projectile;

var() Actor Seeking;
var() vector InitialDir;
var() bool bProjCanLock;
var() int LockTime;

replication
{
    reliable if(Role==ROLE_Authority)
    Seeking, InitialDir, bProjCanLock;
}

simulated function PostBeginPlay()
{
    local Rotator R;

    if ( bDeleteMe || IsInState('Dying') )
    {
        return;
    }

    Super.PostBeginPlay();

    Velocity = Vector(Rotation);
    Velocity *= Speed;
    SetTimer(0.1, true);
    R = Rotation;
    R.Roll = Rand(65536);
    SetRotation(R);
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
    if( Seeking != None && bProjCanLock && LockTime < 20)
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
        Velocity *= (Speed * 2);
        SetTimer(0.0, false);
    }
}

defaultproperties
{
     TrailClass=Class'tk_HalfLife1MonsterPackv2.AlienController_Projectile_Seeking_Trail'
     ExplodeClass=Class'tk_HalfLife1MonsterPackv2.AlienController_Projectile_Seeking_Explode'
     HitSound=Sound'WeaponSounds.BaseImpactAndExplosions.BExplosion3'
     Speed=600.000000
     MaxSpeed=900.000000
     Damage=20.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'tk_HalfLife1MonsterPackv2.DamType_AlienController_Projectile'
}
