class Gonarch extends HalfLife_Monster config(HL1MonsterPackConfig);

var() float LastBabyHeadCrabSpawnSpawnTime;
var() config float BabyHeadCrabSpawnInterval;
var() config bool bCanSpawnBabyHeadCrabs;
var() config int MaxBabyHeadCrabs;
var() config string BabyHeadCrabClass;
var() Name DamageBones[3];
var() Sound BirthSounds[3];
var() Sound ChildKilledSounds[3];

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
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        bShotAnim = true;
    }
    else if(bCanSpawnBabyHeadCrabs && NumBabyHeadCrabs() < MaxBabyHeadCrabs && Level.TimeSeconds - LastBabyHeadCrabSpawnSpawnTime > BabyHeadCrabSpawnInterval)
    {
        LastBabyHeadCrabSpawnSpawnTime = Level.TimeSeconds;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction('Spawn');
        bShotAnim = true;
    }
}

event GainedChild(Actor Other)
{
    if(Other.Class == class'Gonarch_Projectile')
    {
        if ( Controller != None && Controller.Target != None)
        {
			Gonarch_Projectile(Other).Seeking = Controller.Target;

            if(bUseDamageConfig)
            {
                Gonarch_Projectile(Other).Damage = ProjectileDamage;
            }
        }
    }

  Super.GainedChild(Other);
}

function ChildKilled()
{
	PlaySound(ChildKilledSounds[Rand(3)],SLOT_Interact);
}

function SpawnBabyCrab()
{
	local vector X,Y,Z,SpawnOffSet;
	local class<Monster> MonsterClass;
	local Monster M;
    local Inventory Inv;
    local class<Inventory> InvClass;

	GetAxes(Rotation,X,Y,Z);
	SpawnOffSet = X;
	MonsterClass = class<Monster>(DynamicLoadObject(BabyHeadCrabClass, class'class',true));

	if(MonsterClass != None)
	{
		M = Spawn(MonsterClass,self,,location + 300 * SpawnOffSet);
		if(M != None)
		{
			PlaySound(BirthSounds[Rand(3)],SLOT_Interact);

			if(Invasion(Level.Game) != None)
			{
				Invasion(Level.Game).NumMonsters++;
			}

			InvClass = class<Inventory>(DynamicLoadObject("HalfLife1MonsterPack.Gonarch_Inventory",class'class',true));
			if(M.FindInventoryType(InvClass) == None)
			{
				Inv = Spawn(InvClass, M,,,);
				if(Gonarch_Inventory(Inv) != None)
				{
					Gonarch_Inventory(Inv).PawnMaster = Self;
					Inv.GiveTo(M);
				}
			}
		}
	}
}

function int NumBabyHeadCrabs()
{
    local Inventory Inv;
    local int i;

    i = 0;

    foreach DynamicActors(class'Inventory',Inv)
    {
        if(Gonarch_Inventory(Inv) != None && Gonarch_Inventory(Inv).PawnMaster == Self)
        {
            i++;
        }
    }

    return i;
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{
	local int i;
	local bool bHit;

	bHit = false;

	for(i=0;i<3;i++)
	{
		if(VSize(HitLocation - GetBoneCoords(DamageBones[i]).Origin) < 50)
		{
			bHit = true;
			break;
		}
	}

	if(!bHit)
	{
		Damage = 0;
	}

	Super.TakeDamage(Damage, instigatedBy, hitlocation, momentum, damageType);
}

defaultproperties
{
     BabyHeadCrabSpawnInterval=7.000000
     bCanSpawnBabyHeadCrabs=True
     MaxBabyHeadCrabs=4
     BabyHeadCrabClass="tk_HalfLife1MonsterPackv2.BabyHeadCrab"
     DamageBones(0)="Bone02"
     DamageBones(1)="Bone03"
     DamageBones(2)="Bone04"
     BirthSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_birth1'
     BirthSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_birth2'
     BirthSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_birth3'
     ChildKilledSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_childdie1'
     ChildKilledSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_childdie2'
     ChildKilledSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_childdie3'
     MeleeDamage=120.000000
     MeleeDamageBig=175.000000
     RangedAttackIntervalTime=2.600000
     ProjectileDamage=40
     bCanBeTeleFrag=False
     NewHealth=1500
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_attack1'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_attack2'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_attack3'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_attack1'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_sack2'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_attack2'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_attack3'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_attack1'
     FootStepSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_step1'
     FootStepSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_step2'
     FootStepSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_step3'
     FootStepSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_step1'
     RangedAttackAnims(0)="Mortar"
     RangedAttackAnims(1)="Mortar"
     RangedAttackAnims(2)="Mortar"
     RangedAttackAnims(3)="Mortar"
     TauntAnim="Idle01"
     MeleeAnims(0)="Angry02"
     MeleeAnims(1)="Claw"
     MeleeAnims(2)="Angry02"
     MeleeAnims(3)="Claw"
     HitAnims(0)="Flinch"
     HitAnims(1)="Flinch"
     HitAnims(2)="Flinch"
     HitAnims(3)="Flinch"
     DeathAnims(0)="Death01"
     DeathAnims(1)="Death02"
     DeathAnims(2)="Death01"
     DeathAnims(3)="Death02"
     FireProjBone="FireBone"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.Gonarch_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.Gonarch_Projectile'
     bBoss=True
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_pain2'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_pain4'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_pain5'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_pain4'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_die1'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_die1'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_die1'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_alert1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_alert2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_alert3'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.Gonarch_Sounds.gon_alert1'
     ScoringValue=30
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_Gonarch'
     WallDodgeAnims(0)="Run"
     WallDodgeAnims(1)="Run"
     WallDodgeAnims(2)="Run"
     WallDodgeAnims(3)="Run"
     IdleHeavyAnim="Idle02"
     IdleRifleAnim="Idle02"
     FireHeavyRapidAnim="Run"
     FireHeavyBurstAnim="Run"
     FireRifleRapidAnim="Run"
     FireRifleBurstAnim="Run"
     MeleeRange=150.000000
     GroundSpeed=500.000000
     WaterSpeed=500.000000
     Health=1500
     MovementAnims(0)="Run"
     MovementAnims(1)="Run"
     MovementAnims(2)="Run"
     MovementAnims(3)="Run"
     TurnLeftAnim="Run"
     TurnRightAnim="Run"
     SwimAnims(0)="Run"
     SwimAnims(1)="Run"
     SwimAnims(2)="Run"
     SwimAnims(3)="Run"
     CrouchAnims(0)="Run"
     CrouchAnims(1)="Run"
     CrouchAnims(2)="Run"
     CrouchAnims(3)="Run"
     WalkAnims(0)="Run"
     WalkAnims(1)="Run"
     WalkAnims(2)="Run"
     WalkAnims(3)="Run"
     AirAnims(0)="Run"
     AirAnims(1)="Run"
     AirAnims(2)="Run"
     AirAnims(3)="Run"
     TakeoffAnims(0)="Run"
     TakeoffAnims(1)="Run"
     TakeoffAnims(2)="Run"
     TakeoffAnims(3)="Run"
     LandAnims(0)="Run"
     LandAnims(1)="Run"
     LandAnims(2)="Run"
     LandAnims(3)="Run"
     DoubleJumpAnims(0)="Run"
     DoubleJumpAnims(1)="Run"
     DoubleJumpAnims(2)="Run"
     DoubleJumpAnims(3)="Run"
     DodgeAnims(0)="Run"
     DodgeAnims(1)="Run"
     DodgeAnims(2)="Run"
     DodgeAnims(3)="Run"
     AirStillAnim="Run"
     TakeoffStillAnim="Run"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Idle02"
     IdleSwimAnim="Idle02"
     IdleWeaponAnim="Idle02"
     IdleRestAnim="Idle02"
     IdleChatAnim="Idle02"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.Gonarch_Mesh'
     PrePivot=(Z=-95.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.Gonarch_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.Gonarch_Tex01'
     CollisionRadius=80.000000
     CollisionHeight=90.000000
     Mass=1800.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.Gonarch.PawnKParams'

}
