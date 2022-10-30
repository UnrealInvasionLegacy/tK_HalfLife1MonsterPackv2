class HoundEye extends HalfLife_Monster config(HL1MonsterPackConfig);

var() class<Emitter> SonicWaveClass;
var() config float SonicWaveRadius;
var() config float PackDamageMultiplier;
var() config float PackRadius;
var() int PackNumber;

function RangedAttack(Actor A)
{
	local float EnemyDistance;

	Super.RangedAttack(A);

	EnemyDistance = VSize(A.Location - Location);

    if( Level.TimeSeconds - LastRangedAttackTime > RangedAttackIntervalTime && EnemyDistance < SonicWaveRadius)
    {
		LastRangedAttackTime = Level.TimeSeconds;
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        bShotAnim = true;
    }
    else if( EnemyDistance < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction(MeleeAnims[Rand(4)]);
        bShotAnim = true;
    }
}

function SetPackInformation()
{
	local Monster M;

	PackNumber = 1;

    foreach VisibleCollidingActors(class'Monster', M, PackRadius, Location)
    {
		if(M != Self && HoundEye(M) != None && HoundEye(M).Health > 0)
		{
			PackNumber++;
		}
	}
}

function FireProjectile()
{
	local Coords BoneLocation;
    local Actor P;
    local vector dir;
    local float damageScale, dist, Momentum;

	ProjectileDamage = default.ProjectileDamage;
	BoneLocation = GetBoneCoords(FireProjBone);
    Spawn(SonicWaveClass,Self,,BoneLocation.Origin,Rotation);

    SetPackInformation();

	ProjectileDamage *= (PackDamageMultiplier*PackNumber);

   	foreach VisibleCollidingActors(class'Actor', P, SonicWaveRadius, Location)
	{
		if(xPawn(P) != None && xPawn(P).Health > 0 && xPawn(P) != Self && xPawn(P).Controller != None && !xPawn(P).Controller.IsA('MonsterController'))
		{
			Momentum = 100 * xPawn(P).CollisionRadius;
			dir = xPawn(P).Location - Location;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - xPawn(P).CollisionRadius)/SonicWaveRadius);
			xPawn(P).TakeDamage(damageScale * ProjectileDamage,self,xPawn(P).Location - 0.5 * (xPawn(P).CollisionHeight + xPawn(P).CollisionRadius) * dir,(damageScale * Momentum * dir), class'DamType_HoundEye_SonicWave');
		}

		if(TransBeacon(P) != None)
		{
			P.TakeDamage(ProjectileDamage, self, P.Location, vect(0,0,0), class'DamType_HoundEye_SonicWave');
		}
	}

	PlaySound(AttackSounds[Rand(4)],SLOT_Interact);
}

defaultproperties
{
     SonicWaveClass=Class'tk_HalfLife1MonsterPackv2.HoundEye_SonicWave'
     SonicWaveRadius=275.000000
     PackDamageMultiplier=1.200000
     PackRadius=750.000000
     PackNumber=1
     RangedAttackIntervalTime=1.800000
     ProjectileDamage=12
     NewHealth=30
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_attack1'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_attack2'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_attack3'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_attack1'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_blast1'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_blast2'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_blast3'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_blast1'
     RangedAttackAnims(0)="Sonic"
     RangedAttackAnims(1)="Sonic"
     RangedAttackAnims(2)="Sonic"
     RangedAttackAnims(3)="Sonic"
     TauntAnim="LeaderLook"
     MeleeAnims(0)="Melee"
     MeleeAnims(1)="Melee"
     MeleeAnims(2)="Melee"
     MeleeAnims(3)="Melee"
     HitAnims(0)="Flinch01"
     HitAnims(1)="Flinch02"
     HitAnims(2)="Flinch01"
     HitAnims(3)="Flinch02"
     DeathAnims(0)="Die01"
     DeathAnims(1)="Die02"
     DeathAnims(2)="Die05"
     DeathAnims(3)="Die04"
     FireProjBone="Bip01"
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_pain4'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_die2'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_die3'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_die1'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_attack1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_attack2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_attack3'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.HoundEye_Sounds.he_attack1'
     ScoringValue=4
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_HoundEye'
     WallDodgeAnims(0)="Run"
     WallDodgeAnims(1)="Run"
     WallDodgeAnims(2)="Run"
     WallDodgeAnims(3)="Run"
     IdleHeavyAnim="Idle03"
     IdleRifleAnim="Idle03"
     FireHeavyRapidAnim="Run"
     FireHeavyBurstAnim="Run"
     FireRifleRapidAnim="Run"
     FireRifleBurstAnim="Run"
     GroundSpeed=480.000000
     Health=30
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
     IdleCrouchAnim="Idle03"
     IdleSwimAnim="Idle03"
     IdleWeaponAnim="Idle03"
     IdleRestAnim="Idle03"
     IdleChatAnim="Idle03"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.HoundEye_Mesh'
     PrePivot=(Z=-27.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.HoundEye_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.HoundEye_Tex01'
     CollisionRadius=20.000000
     CollisionHeight=20.000000
     Mass=150.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.HoundEye.PawnKParams'

}
