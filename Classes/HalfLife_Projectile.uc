class HalfLife_Projectile extends Projectile placeable;

var() class<Emitter> TrailClass;
var() class<Emitter> ExplodeClass;
var() Emitter Trail;
var() Sound HitSound;

simulated function Destroyed()
{
    if( Trail != None )
    {
         Trail.Destroy();
    }
}

simulated function PostBeginPlay()
{
	Local vector Dir;

    Dir = vector(Rotation);
    Velocity = Speed * Dir;

    if( Level.NetMode != NM_DedicatedServer)
    {
        Trail = Spawn(TrailClass,self);
        if(Trail != None)
        {
        	Trail.SetBase(Self);
		}
    }

    Super.PostBeginPlay();
}

simulated function Landed( vector HitNormal )
{
    Explode(Location,HitNormal);
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
    if( (Other != instigator) && (!Other.IsA('Projectile') || Other.bProjTarget) )
    {
        Explode(HitLocation,Vect(0,0,1));
	}
}

function BlowUp(vector HitLocation)
{
    HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, HitLocation );
    MakeNoise(1.0);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    PlaySound(HitSound,,2.5*TransientSoundVolume);
    Spawn(ExplodeClass,,,HitLocation + HitNormal*16 );
    BlowUp(HitLocation);
    Destroy();
}

defaultproperties
{
     Speed=1000.000000
     MaxSpeed=1500.000000
     Damage=15.000000
     DamageRadius=50.000000
     MomentumTransfer=50000.000000
     MyDamageType=None
     DrawType=DT_Sprite
     bNetTemporary=False
     AmbientSound=Sound'WeaponSounds.RocketLauncher.RocketLauncherProjectile'
     LifeSpan=10.000000
     Texture=FinalBlend'XEffectMat.Combos.InvisOverlayFB'
     DrawScale=0.300000
     Style=STY_Translucent
}
