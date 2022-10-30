//Grunt_Projectile by Shaun Goeppinger aka Iniquitous
// www.unreal.shaungoeppinger.com
// Seeking Projectile which bounces off walls/surfaces and around corners chasing its target or until it finds a new target
// (lifespan destroys it)
class Grunt_Projectile extends HalfLife_Projectile;

var() Actor Seeking;
var() vector InitialDir;
var() bool bHornetCanLock;
var() bool bLocked;
var() float SnoozeTime; //pause seeking when initial spawn to allow grunt to set target
var() float InitialSnoozeTime;
var() vector Dir;
var() Sound HitSounds[3];
var() int NumHornetBounces;
var() bool bHornetCanBounceCorners;

replication
{
    reliable if(Role==ROLE_Authority)
    	Seeking, InitialDir, bHornetCanLock, NumHornetBounces, bHornetCanBounceCorners;
}

simulated function PostBeginPlay()
{
	InitialSnoozeTime = Level.TimeSeconds;

    if ( bDeleteMe || IsInState('Dying') )
    {
        return;
    }

    Super.PostBeginPlay();
	HitSound = HitSounds[Rand(3)];
    Dir = vector(Rotation);
    Velocity = (Speed + Rand(MaxSpeed-Speed)) * Dir;
    SetTimer(0.1, true);
}

simulated function Timer()
{
    local vector ForceDir;
    local float VelMag, BadLuck, MostBadLuck;
    local Controller C;
    local Pawn NewTarget;

    if( InitialDir == vect(0,0,0) )
    {
        InitialDir = Normal(Velocity);
    }

	MostBadLuck = 0;
	BadLuck = 0;
	NewTarget = None;
    Acceleration = vect(0,0,0);

    Super.Timer();

    if( Seeking != None && bHornetCanLock)
    {
        ForceDir = Normal(Seeking.Location + vect(0,0,20) - Location);

        VelMag = VSize(Velocity);

        ForceDir = Normal(ForceDir * 1.1 * VelMag + Velocity);
        Velocity = VelMag * ForceDir;
        Acceleration += 2 * ForceDir;
        SetRotation(rotator(Velocity));
    }
    else if(bHornetCanLock && Level.TimeSeconds - InitialSnoozeTime > SnoozeTime)
    {
		//else if Grunts target died then find new target
		//check controller list
		if(Role == Role_Authority)
		{
			for ( C = Level.ControllerList; C != None; C = C.NextController )
			{
				if(C.Pawn != None && C.Pawn.Health > 0)
				{
					if ( (C.PlayerReplicationInfo != None) && (C.IsA('PlayerController') || C.PlayerReplicationInfo.bBot) && FastTrace(C.Pawn.Location,Location))
					{
						BadLuck = Rand(1000);
						if (BadLuck > MostBadLuck)
						{
							MostBadLuck= BadLuck;
							NewTarget = C.Pawn;
						}
					}
				}
			}

			if(NewTarget != None)
			{
				Seeking = NewTarget;
			}

			return;
		}
	}
    else
    {
    	Dir = vector(Rotation);
    	Velocity = (Speed + Rand(MaxSpeed-Speed)) * Dir;
        Acceleration += 2 * Velocity;
        SetRotation(rotator(Velocity));
    }
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    if ( !Wall.bStatic && !Wall.bWorldGeometry
        && ((Mover(Wall) == None) || Mover(Wall).bDamageTriggered) )
    {
        if ( Level.NetMode != NM_Client )
        {
            if ( Instigator == None || Instigator.Controller == None )
                Wall.SetDelayedDamageInstigatorController( InstigatorController );
            Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
        }
        Destroy();
        return;
    }

	if(bHornetCanBounceCorners && NumHornetBounces > 0)
	{
		NumHornetBounces--;
		Velocity = 0.65 * (Velocity - 2.0*HitNormal*(Velocity dot HitNormal));
		SetRotation(rotator(Velocity));
		Dir = vector(Rotation);
		Velocity = (Speed + Rand(MaxSpeed-Speed)) * Dir;
		Acceleration += 2 * Velocity;
		SetRotation(rotator(Velocity));
	}
	else
	{
		Explode(Location,HitNormal);
	}
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    PlaySound(HitSound,,1.3*TransientSoundVolume);
    Spawn(ExplodeClass,,,HitLocation);
    BlowUp(HitLocation);
    Destroy();
}

defaultproperties
{
     bHornetCanLock=True
     SnoozeTime=1.250000
     HitSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Hornet_Sounds.ag_hornethit1'
     HitSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Hornet_Sounds.ag_hornethit2'
     HitSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Hornet_Sounds.ag_hornethit3'
     NumHornetBounces=3
     bHornetCanBounceCorners=True
     TrailClass=Class'tk_HalfLife1MonsterPackv2.Grunt_Projectile_Trail'
     ExplodeClass=Class'tk_HalfLife1MonsterPackv2.Grunt_Projectile_Explosion'
     Speed=400.000000
     MaxSpeed=800.000000
     Damage=12.000000
     DamageRadius=20.000000
     MomentumTransfer=0.000000
     MyDamageType=Class'tk_HalfLife1MonsterPackv2.DamType_Grunt_Projectile'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'tk_HalfLife1MonsterPackv2.Statics.Hornet_Mesh'
     AmbientSound=None
     DrawScale=1.000000
     PrePivot=(X=4.000000)
     CollisionRadius=5.000000
     CollisionHeight=5.000000
     bBounce=True
}
