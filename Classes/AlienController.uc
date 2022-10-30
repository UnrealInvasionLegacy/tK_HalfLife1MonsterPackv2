class AlienController extends HalfLife_Monster config(HL1MonsterPackConfig);

var() config bool bProjCanLock;
var() config int SeekingProjectileDamage;
var() float Spread;

function RangedAttack(Actor A)
{

	Super.RangedAttack(A);

    if( VSize(A.Location - Location) < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction(MeleeAnims[Rand(4)]);
        bShotAnim = true;
    }
    else if(Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime)
    {
        LastRangedAttackTime = Level.TimeSeconds;
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        bShotAnim = true;
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
		iProj = Rand(3) + 1;

		if(Rand(2) == 1)
		{
			Y *= -1;
        }

        for(i=0;i<iProj;i++)
        {
            FireStart = BoneLocation.Origin + 1 * SpawnOffSet + (Max(5,(8 * Rand(10))) * Y) + (Max(5,(8 * Rand(10))) * Z);
           	Aim = Controller.AdjustAim(SavedFireProperties,FireStart, 0);
           	W = Vector(Aim);
			R.Yaw = Spread * (FRand()-0.5);
			R.Pitch = Spread * (FRand()-0.5);
            R.Roll = Spread * (FRand()-0.5);
            Spawn(ProjectileClass[0],self,,FireStart,Rotator(W >> R));
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
            FireStart = BoneLocation.Origin + 1 * SpawnOffSet + (Max(5,(8 * Rand(10))) * Y) + (Max(5,(8 * Rand(10))) * Z);
           	Aim = Controller.AdjustAim(SavedFireProperties,FireStart, 0);
           	W = Vector(Aim);
			R.Yaw = Spread * (FRand()-0.5);
			R.Pitch = Spread * (FRand()-0.5);
            R.Roll = Spread * (FRand()-0.5);
            Spawn(ProjectileClass[0],self,,FireStart,Rotator(W >> R));
        }

		PlaySound(AttackSounds[Rand(4)],SLOT_Interact,100);
    }
}

function FireProjectileLarge()
{
	local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None)
    {
		BoneLocation = GetBoneCoords(FireProjBone);
        Proj = Spawn(ProjectileClass[1],Self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));

        if(Proj != None)
        {
            PlaySound(AttackSounds[Rand(4)],SLOT_Interact);
        }
    }
}

function FireProjectileLeft()
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
		iProj = Rand(3) + 1;

		if(Rand(2) == 1)
		{
			Y *= -1;
        }

        for(i=0;i<iProj;i++)
        {
            FireStart = BoneLocation.Origin + 1 * SpawnOffSet + (Max(5,(8 * Rand(10))) * Y) + (Max(5,(8 * Rand(10))) * Z);
           	Aim = Controller.AdjustAim(SavedFireProperties,FireStart, 0);
           	W = Vector(Aim);
			R.Yaw = Spread * (FRand()-0.5);
			R.Pitch = Spread * (FRand()-0.5);
            R.Roll = Spread * (FRand()-0.5);
            Spawn(ProjectileClass[0],self,,FireStart,Rotator(W >> R));
        }

		PlaySound(AttackSounds[Rand(4)],SLOT_Interact,100);
    }
}

event GainedChild(Actor Other)
{
	if ( Controller != None && Controller.Target != None)
	{
		if(Other.Class == class'AlienController_Projectile_Seeking')
		{
			AlienController_Projectile_Seeking(Other).bProjCanLock = bProjCanLock;
			AlienController_Projectile_Seeking(Other).Seeking = Controller.Target;

			if(bUseDamageConfig)
			{
				AlienController_Projectile_Seeking(Other).Damage = SeekingProjectileDamage;
			}
		}
		else if(Other.Class == class'AlienController_Projectile')
		{
			if(bUseDamageConfig)
			{
				AlienController_Projectile(Other).Damage = ProjectileDamage;
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

defaultproperties
{
     bProjCanLock=True
     SeekingProjectileDamage=20
     Spread=1400.000000
     MeleeDamage=20.000000
     RangedAttackIntervalTime=1.700000
     ProjectileDamage=8
     NewHealth=60
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_idle2'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_idle3'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_idle4'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_idle5'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_attack1'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_attack2'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_attack3'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_attack1'
     RangedAttackAnims(0)="Attack01"
     RangedAttackAnims(1)="Block"
     RangedAttackAnims(2)="Shoot"
     RangedAttackAnims(3)="Throw"
     TauntAnim="Idle01"
     MeleeAnims(0)="Melee"
     MeleeAnims(1)="Melee"
     MeleeAnims(2)="Melee"
     MeleeAnims(3)="Melee"
     HitAnims(0)="Flinch01"
     HitAnims(1)="Flinch02"
     HitAnims(2)="Flinch01"
     HitAnims(3)="Flinch02"
     DeathAnims(0)="Die01"
     DeathAnims(1)="Die01"
     DeathAnims(2)="Die01"
     DeathAnims(3)="Die01"
     FireProjBone="FireBone"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.AlienController_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.AlienController_Projectile_Seeking'
     bMeleeFighter=False
     DodgeSkillAdjust=4.000000
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_pain1'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_die2'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_die1'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_die2'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_alert1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_alert2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_alert3'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.AlienController_Sounds.con_idle1'
     ScoringValue=10
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_AlienController'
     WallDodgeAnims(0)="DodgeL"
     WallDodgeAnims(1)="DodgeL"
     WallDodgeAnims(2)="DodgeR"
     WallDodgeAnims(3)="DodgeR"
     IdleHeavyAnim="Idle01"
     IdleRifleAnim="Idle01"
     FireHeavyRapidAnim="Walk"
     FireHeavyBurstAnim="Walk"
     FireRifleRapidAnim="Walk"
     FireRifleBurstAnim="Walk"
     bCanFly=True
     MeleeRange=30.000000
     GroundSpeed=400.000000
     AirSpeed=400.000000
     Health=60
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
     DodgeAnims(0)="Left"
     DodgeAnims(1)="Right"
     DodgeAnims(2)="Left"
     DodgeAnims(3)="Right"
     AirStillAnim="Walk"
     TakeoffStillAnim="Walk"
     CrouchTurnRightAnim="Walk"
     CrouchTurnLeftAnim="Walk"
     IdleCrouchAnim="Idle01"
     IdleSwimAnim="Idle01"
     IdleWeaponAnim="Idle01"
     IdleRestAnim="Idle01"
     IdleChatAnim="Idle01"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.AlienController_Mesh'
     DrawScale=1.500000
     PrePivot=(Z=-40.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.AlienController_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.AlienController_Tex01'
     CollisionRadius=28.000000
     CollisionHeight=45.000000
     Mass=120.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.AlienController.PawnKParams'

}
