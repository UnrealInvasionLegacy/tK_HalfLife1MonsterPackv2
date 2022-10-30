class Gargantua extends HalfLife_Monster config(HL1MonsterPackConfig);

var() float FlameRange;
var() config int FlameDamagePerSecond;
var() config float ShockWaveInterval;
var() config int ShockDamage;
var() config float ShockRadius;
var() config array<String> ImmuneDamageType;
var() float LastShockWave;
var() Emitter LHandFX, RHandFX;
var() bool bFlamePower;
var() Name FireBones[8];
var() Name VehicleAttackAnims[2];
var() float VehicleMomentumScale;

function RangedAttack(Actor A)
{
	Super.RangedAttack(A);

    if( VSize(A.Location - Location) < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
		Controller.bPreparingMove = true;
		Acceleration = vect(0,0,0);

		if(ONSVehicle(A) != None)
		{
			SetAnimAction(VehicleAttackAnims[Rand(2)]);
		}
		else
		{
			SetAnimAction(MeleeAnims[Rand(4)]);
		}

		bShotAnim = true;

    }
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime && VSize(A.Location - Location) < FlameRange + CollisionRadius + A.CollisionRadius)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        bShotAnim = true;
    }
    else if(Level.TimeSeconds - LastShockWave > ShockWaveInterval)
    {
        LastShockWave = Level.TimeSeconds;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction('Stomp');
        bShotAnim = true;
    }
}

function Kick()
{
	local Vector PushValue;

    if(Controller != None && Controller.Target != None)
    {
		if(ONSVehicle(Controller.Target) != None)
		{
			PushValue = Normal(Controller.Target.Location - Location) * ONSVehicle(Controller.Target).VehicleMass * (2*VehicleMomentumScale);
			PushValue.Z += 	200 * ONSVehicle(Controller.Target).VehicleMass;
		}
		else
		{
			PushValue = Normal(Controller.Target.Location - Location) * VehicleMomentumScale;
			PushValue.Z += 	200;
		}

        if (MeleeDamageVehicle(MeleeDamage, (30000 * Normal(Controller.Target.Location - Location))) )
        {
			Controller.Target.TakeDamage( 0, Self, Controller.Target.Location,PushValue, class'DamType_Gargantua_Shock');
            PlaySound(MeleeAttackSounds[Rand(4)], SLOT_Interact);
        }
        else
        {
            PlaySound(MissSound[Rand(4)], SLOT_Interact);
        }
    }
}

function bool MeleeDamageVehicle(int hitdamage, vector pushdir)
{
    local vector HitLocation, HitNormal;
    local actor HitActor;

    // check if still in melee range
    If ( (Controller.target != None) && (VSize(Controller.Target.Location - Location) <= (MeleeRange + 50) * 1.4 + Controller.Target.CollisionRadius + CollisionRadius)
        && ((Physics == PHYS_Flying) || (Physics == PHYS_Swimming) || (Abs(Location.Z - Controller.Target.Location.Z)
            <= FMax(CollisionHeight, Controller.Target.CollisionHeight) + 0.5 * FMin(CollisionHeight, Controller.Target.CollisionHeight))) )
    {
        HitActor = Trace(HitLocation, HitNormal, Controller.Target.Location, Location, false);
        if ( HitActor != None )
            return false;
        Controller.Target.TakeDamage(hitdamage, self,HitLocation, pushdir, class'MeleeDamage');
        return true;
    }
    return false;
}

function RedFire()
{
    local Coords BoneLocation;
	local Rotator Rot;

    if ( Controller != None )
    {
		Rot = Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError);

        BoneLocation = GetBoneCoords('Bip01 L Foot');

        Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin,Rot);

		Rot = Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError);
		Rot.Yaw += -2800;

		Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin, Rot);

		Rot = Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError);
		Rot.Yaw += 6728;
		Spawn(ProjectileClass[Rand(2)],self,,BoneLocation.Origin, Rot);
    }
}

event GainedChild(Actor Other)
{
	if ( Controller != None && Controller.Target != None)
	{
		if(Other.Class == class'Gargantua_Projectile')
		{
			if(bUseDamageConfig)
			{
				Gargantua_Projectile(Other).Damage = ProjectileDamage;
			}
		}
	}

  Super.GainedChild(Other);
}

simulated function ShockWave()
{
	local Coords BoneLocation;

	bFlamePower = true;

	if ( Level.NetMode != NM_DedicatedServer )
	{
		BoneLocation = GetBoneCoords('Bip01 L Foot');
		Spawn(class'Gargantua_ShockWave', Self,,BoneLocation.Origin,);
	}

	ShockWaveDamage(Mass/4);
	RedFire();
}

function ShockWaveDamage(int Power)
{
	local float DamageScale, Dist, Shake;
    local vector Momentum, Dir;
    local Coords BoneLocation;
    local xPawn P;

	BoneLocation = GetBoneCoords('Bip01 L Foot');
	PlaySound(Sound'gar_stomp1',SLOT_Interact);

	foreach RadiusActors(class'xPawn', P, ShockRadius, BoneLocation.Origin)
	{
		if(P != None && P.Health > 0 && P != Self && P.Physics != PHYS_Falling && P.Controller != None && !P.Controller.IsA('MonsterController'))
		{
			Dist = VSize(Location - P.Location);
			Momentum = 175 * Vrand();
		    Momentum.Z = FClamp(0,Power,Power - ( 0.4 * Dist + Max(10,P.Mass)*10));
			Dir = P.Location - BoneLocation.origin;
			Dist = FMax(1,VSize(Dir));
			Dir = Dir/Dist;
    		P.AddVelocity(Momentum);
			Shake = 0.4*FMax(500, Mass - Dist);
       		Shake=FMin(2000,Shake);
			DamageScale = 1 - FMax(0,(Dist - P.CollisionRadius)/ShockRadius);
			P.TakeDamage(DamageScale * ShockDamage,self,P.Location - 0.5 * (P.CollisionHeight + P.CollisionRadius) * Dir,(DamageScale * Momentum * dir), class'DamType_Gargantua_Shock');
            P.Controller.ShakeView( vect(0.0,0.02,0.0)*Shake, vect(0,1000,0),0.003*Shake, vect(0.02,0.02,0.02)*Shake, vect(1000,1000,1000),0.003*Shake);
		}
	}
}

simulated function FireProjectile()
{}

simulated function FireProjectileEnd()
{
	bFlamePower = false;
	RemoveEffects();
}

simulated function FireProjectileFX()
{
	local Coords BoneLocation;
	local Rotator BoneRotation;

	bFlamePower = true;

	if ( Level.NetMode != NM_DedicatedServer )
	{
		BoneLocation = GetBoneCoords('FireL01');
		BoneRotation = GetBoneRotation('FireL01',);
		LHandFX = Spawn(class'Gargantua_Flame', Self,,BoneLocation.Origin,BoneRotation);
		AttachToBone(LHandFX,'FireL01');

		BoneLocation = GetBoneCoords('FireR01');
		BoneRotation = GetBoneRotation('FireR01',);
		RHandFX = Spawn(class'Gargantua_Flame', Self,,BoneLocation.Origin,BoneRotation);
		AttachToBone(RHandFX,'FireR01');
	}

	if(Role == Role_Authority)
	{
		PlaySound(Sound'gar_flameon1',SLOT_Interact);
		AmbientSound = Sound'gar_flamerun1';
	}
}

simulated function AnimEnd(int Channel)
{
	AmbientSound = None;

	if(bFlamePower)
	{
		if(Role == Role_Authority)
		{
			PlaySound(Sound'gar_flameoff1',SLOT_Interact);
		}
	}

	bFlamePower = false;
	RemoveEffects();
	Super.AnimEnd(Channel);
}

simulated State Flaming
{
	simulated function BeginState()
	{
		SetTimer(0.25,true);
	}

	simulated function EndState()
	{
		RemoveEffects();
	}

	function Timer()
	{
		local Pawn P;
		local int i;
		local float FlameDamage;

		if(bFlamePower)
		{
			FlameDamage = FlameDamagePerSecond/4;
			foreach DynamicActors(class'Pawn',P, )
			{
				if(P != None && P != Self)
				{
					for(i=0;i<8;i++)
					{
						if(VSize(P.Location - GetBoneCoords(FireBones[i]).Origin) < 100)
						{
							P.TakeDamage(int(FlameDamage), Self, P.Location, vect(1000,0,0), class'DamType_Gargantua_Flames');
						}
					}
				}
			}
		}
	}
}

simulated function RemoveEffects()
{
	if(RHandFX != None)
	{
		RHandFX.Kill();
	}

	if(LHandFX != None)
	{
		LHandFX.Kill();
	}
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{
	local int i;
	local class<DamageType> ImmuneDamageClass;

    if(damageType != None)
    {
		for(i=0;i<ImmuneDamageType.Length;i++)
		{
			ImmuneDamageClass = class<DamageType>(DynamicLoadObject(ImmuneDamageType[i],class'class',true));
			if(ImmuneDamageClass != None && ClassIsChildOf(damageType, ImmuneDamageClass))
			{
				Damage = 0;
				break;
			}
		}
	}

	Super.TakeDamage(Damage, instigatedBy, hitlocation, momentum, damageType);
}

defaultproperties
{
     FlameRange=300.000000
     FlameDamagePerSecond=30
     ShockWaveInterval=4.000000
     ShockDamage=25
     ShockRadius=1024.000000
     ImmuneDamageType(0)="XWeapons.DamTypeMinigunBullet"
     ImmuneDamageType(1)="UTClassic.DamTypeClassicSniper"
     ImmuneDamageType(2)="XWeapons.DamTypeAssaultBullet"
     ImmuneDamageType(3)="XWeapons.DamTypeShockBeam"
     ImmuneDamageType(4)="XWeapons.DamTypeLinkShaft"
     ImmuneDamageType(5)="XWeapons.DamTypeSniperShot"
     ImmuneDamageType(6)="XWeapons.DamTypeSniperHeadShot"
     FireBones(0)="FireR01"
     FireBones(1)="FireR02"
     FireBones(2)="FireR03"
     FireBones(3)="FireR04"
     FireBones(4)="FireL01"
     FireBones(5)="FireL02"
     FireBones(6)="FireL03"
     FireBones(7)="FireL04"
     VehicleAttackAnims(0)="Roll"
     VehicleAttackAnims(1)="Kick"
     VehicleMomentumScale=20000.000000
     MeleeDamage=80.000000
     MeleeDamageBig=110.000000
     RangedAttackIntervalTime=3.500000
     bCanBeTeleFrag=False
     NewHealth=800
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_attack1'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_attack2'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_attack3'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_attack1'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_attack1'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_attack2'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_attack3'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_attack1'
     FootStepSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_step1'
     FootStepSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_step2'
     FootStepSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_step1'
     FootStepSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_step2'
     RangedAttackAnims(0)="ShootFlames03"
     RangedAttackAnims(1)="ShootFlames03"
     RangedAttackAnims(2)="ShootFlames04"
     RangedAttackAnims(3)="ShootFlames04"
     TauntAnim="Idle03"
     MeleeAnims(0)="Attack"
     MeleeAnims(1)="Attack"
     MeleeAnims(2)="Attack"
     MeleeAnims(3)="Attack"
     HitAnims(0)="FinchHeavy"
     HitAnims(1)="FlinchLight"
     HitAnims(2)="FlinchLight"
     HitAnims(3)="FlinchHeavy"
     DeathAnims(0)="Die"
     DeathAnims(1)="Die"
     DeathAnims(2)="Die"
     DeathAnims(3)="Die"
     FireProjBone="Bip01 L Foot"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.Gargantua_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.Gargantua_Projectile'
     bCanDodge=False
     bBoss=True
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_pain1'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_die2'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_die1'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_die2'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_alert1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_alert2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_alert3'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.Gargantua_Sounds.gar_idle5'
     ScoringValue=50
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_Gargantua'
     WallDodgeAnims(0)="Walk"
     WallDodgeAnims(1)="Walk"
     WallDodgeAnims(2)="Walk"
     WallDodgeAnims(3)="Walk"
     IdleHeavyAnim="Idle03"
     IdleRifleAnim="Idle03"
     FireHeavyRapidAnim="Walk"
     FireHeavyBurstAnim="Walk"
     FireRifleRapidAnim="Walk"
     FireRifleBurstAnim="Walk"
     bCanJump=False
     MeleeRange=120.000000
     GroundSpeed=525.000000
     WaterSpeed=500.000000
     Health=800
     MovementAnims(0)="Walk"
     MovementAnims(1)="Walk"
     MovementAnims(2)="Walk"
     MovementAnims(3)="Walk"
     TurnLeftAnim="Walk"
     TurnRightAnim="Walk"
     SwimAnims(0)="Walk"
     SwimAnims(1)="Walk"
     SwimAnims(2)="Walk"
     SwimAnims(3)="Walk"
     CrouchAnims(0)="Walk"
     CrouchAnims(1)="Walk"
     CrouchAnims(2)="Walk"
     CrouchAnims(3)="Walk"
     WalkAnims(0)="Walk"
     WalkAnims(1)="Walk"
     WalkAnims(2)="Walk"
     WalkAnims(3)="Walk"
     AirAnims(0)="Walk"
     AirAnims(1)="Walk"
     AirAnims(2)="Walk"
     AirAnims(3)="Walk"
     TakeoffAnims(0)="Walk"
     TakeoffAnims(1)="Walk"
     TakeoffAnims(2)="Walk"
     TakeoffAnims(3)="Walk"
     LandAnims(0)="Walk"
     LandAnims(1)="Walk"
     LandAnims(2)="Walk"
     LandAnims(3)="Walk"
     DoubleJumpAnims(0)="Walk"
     DoubleJumpAnims(1)="Walk"
     DoubleJumpAnims(2)="Walk"
     DoubleJumpAnims(3)="Walk"
     DodgeAnims(0)="Walk"
     DodgeAnims(1)="Walk"
     DodgeAnims(2)="Walk"
     DodgeAnims(3)="Walk"
     AirStillAnim="Walk"
     TakeoffStillAnim="Walk"
     CrouchTurnRightAnim="Walk"
     CrouchTurnLeftAnim="Walk"
     IdleCrouchAnim="Idle03"
     IdleSwimAnim="Idle03"
     IdleWeaponAnim="Idle03"
     IdleRestAnim="Idle03"
     IdleChatAnim="Idle03"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.Gargantua_Mesh'
     InitialState="Flaming"
     DrawScale=1.200000
     PrePivot=(Z=-115.000000)
     Skins(0)=Shader'tk_HalfLife1MonsterPackv2.All.Gargantua_Tex01_S'
     Skins(1)=Shader'tk_HalfLife1MonsterPackv2.All.Gargantua_Tex01_S'
     CollisionRadius=100.000000
     CollisionHeight=105.000000
     Mass=1500.000000
     Begin Object Class=KarmaParamsSkel Name=PawnKParams
         KConvulseSpacing=(Max=2.200000)
         KMass=700.000000
         KLinearDamping=0.150000
         KAngularDamping=0.050000
         KBuoyancy=1.000000
         KStartEnabled=True
         KVelDropBelowThreshold=50.000000
         bHighDetailOnly=False
         KFriction=1.700000
         KRestitution=0.050000
         KImpactThreshold=300.000000
     End Object
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.Gargantua.PawnKParams'

}
