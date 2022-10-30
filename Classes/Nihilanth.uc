class Nihilanth extends HalfLife_Monster config(HL1MonsterPackConfig);

var() float Spread;
var() float LastTeleportTime;
var() config float TeleportIntervalTime;
var() config bool bCanTeleportPlayers;

event PostBeginPlay()
{
    Super.PostBeginPlay();

    if(bCanTeleportPlayers)
    {
		SetTimer(1.00,true);
	}
}

function RangedAttack(Actor A)
{

	Super.RangedAttack(A);

    if( VSize(A.Location - Location) < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction(MeleeAnims[Rand(4)]);
        bShotAnim = true;
        LastTeleportTime = Level.TimeSeconds;
    }
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        bShotAnim = true;
        LastTeleportTime = Level.TimeSeconds;
    }
}

function Timer()
{
	if(Controller != None && Controller.Target != None)
	{
		if(Level.TimeSeconds - LastTeleportTime > TeleportIntervalTime && !FastTrace(Controller.Target.Location - Location))
		{
			PlaySound(Sound'x_teleattack1',SLOT_Interact);
			LastTeleportTime = Level.TimeSeconds;
			SetAnimAction('Recharge');
			bShotAnim = true;
			TeleportPlayer(Controller.Target);
    	}
	}
}

function TeleportPlayer(Actor A)
{
	local NavigationPoint N;

	if(A != None && !A.bStatic)
	{
		for (N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint)
		{
			if(FastTrace(N.Location,Location))
			{
				A.SetLocation(N.Location);
				break;
			}
		}
	}
}

function FireProjectile()
{
	local Coords BoneLocation;
    local int i, iProj;
    local vector W,X,Y,Z, SpawnOffSet, FireStart;
    local Rotator R, Aim;

    if ( Controller != None)
    {
		BoneLocation = GetBoneCoords('FireBoneL');
		GetAxes(Rotation,X,Y,Z);
		SpawnOffSet = X;
		iProj = Rand(6) + 1;

		if(Rand(2) == 1)
		{
			Y *= -1;
        }

        for(i=0;i<iProj;i++)
        {
            FireStart = BoneLocation.Origin + 1 * SpawnOffSet + (Max(5,(10 * Rand(10))) * Y) + (Max(5,(10 * Rand(10))) * Z);
           	Aim = Controller.AdjustAim(SavedFireProperties,FireStart, 0);
           	W = Vector(Aim);
			R.Yaw = Spread * (FRand()-0.5);
			R.Pitch = Spread * (FRand()-0.5);
            R.Roll = Spread * (FRand()-0.5);
            Spawn(ProjectileClass[Rand(2)],self,,FireStart,Rotator(W >> R));
        }

		BoneLocation = GetBoneCoords('FireBoneR');
		GetAxes(Rotation,X,Y,Z);
		SpawnOffSet = X;

		if(Rand(2) == 1)
		{
			Y *= -1;
        }

        for(i=0;i<iProj;i++)
        {
            FireStart = BoneLocation.Origin + 1 * SpawnOffSet + (Max(5,(10 * Rand(10))) * Y) + (Max(5,(10 * Rand(10))) * Z);
           	Aim = Controller.AdjustAim(SavedFireProperties,FireStart, 0);
           	W = Vector(Aim);
			R.Yaw = Spread * (FRand()-0.5);
			R.Pitch = Spread * (FRand()-0.5);
            R.Roll = Spread * (FRand()-0.5);
            Spawn(ProjectileClass[Rand(2)],self,,FireStart,Rotator(W >> R));
        }

		PlaySound(AttackSounds[Rand(4)],SLOT_Interact,100);
    }
}

event GainedChild(Actor Other)
{
	if ( Controller != None && Controller.Target != None)
	{
		if(Other.Class == class'Nihilanth_Projectile')
		{
			if(bUseDamageConfig)
			{
				Nihilanth_Projectile(Other).Damage = ProjectileDamage;
			}
		}
	}

  Super.GainedChild(Other);
}

function SetMovementPhysics()
{
    SetPhysics(PHYS_Flying);
}

singular function Falling()
{
    SetPhysics(PHYS_Flying);
}

simulated function Boom()
{
	SetDrawType(DT_None);
	Spawn(class'Nihilanth_Explode',self);
	if(Role == Role_Authority)
	{
		PlaySound(Sound'nih_die2',SLOT_Interact);
	}
}

simulated function PlayDying(class<DamageType> DamageType, vector HitLoc)
{
	bHasRagdoll = false;
	Super(Monster).PlayDying(DamageType, HitLoc);
}

defaultproperties
{
     Spread=1400.000000
     TeleportIntervalTime=10.000000
     bCanTeleportPlayers=True
     MeleeDamage=50.000000
     RangedAttackIntervalTime=4.200000
     ProjectileDamage=25
     bCanBeTeleFrag=False
     NewHealth=1600
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_attack1'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_attack2'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_attack3'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_attack1'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_ballattack1'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_ballattack1'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_ballattack1'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_ballattack1'
     RangedAttackAnims(0)="Attack01"
     RangedAttackAnims(1)="Attack01"
     RangedAttackAnims(2)="Shoot"
     RangedAttackAnims(3)="Block"
     TauntAnim="Recharge"
     MeleeAnims(0)="Melee"
     MeleeAnims(1)="Melee"
     MeleeAnims(2)="Melee"
     MeleeAnims(3)="Melee"
     HitAnims(0)="Flinch01"
     HitAnims(1)="Flinch02"
     HitAnims(2)="Flinch01"
     HitAnims(3)="Flinch02"
     DeathAnims(0)="Die02"
     DeathAnims(1)="Die02"
     DeathAnims(2)="Die02"
     DeathAnims(3)="Die02"
     FireProjBone="FireBoneL"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.Nihilanth_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.Nihilanth_Projectile'
     bMeleeFighter=False
     bBoss=True
     DodgeSkillAdjust=4.000000
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_pain1'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_die1'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_die1'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_die1'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_laugh1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_laugh2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_laugh1'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.Nihilanth_Sounds.x_laugh2'
     ScoringValue=10
     WallDodgeAnims(0)="Float"
     WallDodgeAnims(1)="Float"
     WallDodgeAnims(2)="Float"
     WallDodgeAnims(3)="Float"
     IdleHeavyAnim="Float"
     IdleRifleAnim="Float"
     FireHeavyRapidAnim="Float"
     FireHeavyBurstAnim="Float"
     FireRifleRapidAnim="Float"
     FireRifleBurstAnim="Float"
     bCanFly=True
     MeleeRange=120.000000
     GroundSpeed=400.000000
     AirSpeed=300.000000
     Health=1600
     MovementAnims(0)="Float"
     MovementAnims(1)="Float"
     MovementAnims(2)="Float"
     MovementAnims(3)="Float"
     TurnLeftAnim="Float"
     TurnRightAnim="Float"
     SwimAnims(0)="Float"
     SwimAnims(1)="Float"
     SwimAnims(2)="Float"
     SwimAnims(3)="Float"
     CrouchAnims(0)="Float"
     CrouchAnims(1)="Float"
     CrouchAnims(2)="Float"
     CrouchAnims(3)="Float"
     WalkAnims(0)="Float"
     WalkAnims(1)="Float"
     WalkAnims(2)="Float"
     WalkAnims(3)="Float"
     AirAnims(0)="Float"
     AirAnims(1)="Float"
     AirAnims(2)="Float"
     AirAnims(3)="Float"
     TakeoffAnims(0)="Float"
     TakeoffAnims(1)="Float"
     TakeoffAnims(2)="Float"
     TakeoffAnims(3)="Float"
     LandAnims(0)="Float"
     LandAnims(1)="Float"
     LandAnims(2)="Float"
     LandAnims(3)="Float"
     DoubleJumpAnims(0)="Float"
     DoubleJumpAnims(1)="Float"
     DoubleJumpAnims(2)="Float"
     DoubleJumpAnims(3)="Float"
     DodgeAnims(0)="Float"
     DodgeAnims(1)="Float"
     DodgeAnims(2)="Float"
     DodgeAnims(3)="Float"
     AirStillAnim="Float"
     TakeoffStillAnim="Float"
     CrouchTurnRightAnim="Float"
     CrouchTurnLeftAnim="Float"
     IdleCrouchAnim="Float"
     IdleSwimAnim="Float"
     IdleWeaponAnim="Float"
     IdleRestAnim="Float"
     IdleChatAnim="Float"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.Nihilanth_Mesh'
     DrawScale=0.400000
     PrePivot=(Z=-75.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.Nihilanth_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.Nihilanth_Tex01'
     CollisionRadius=75.000000
     CollisionHeight=200.000000
     Mass=2000.000000
}
