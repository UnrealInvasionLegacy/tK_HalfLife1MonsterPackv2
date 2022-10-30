class PitDrone extends HalfLife_Monster config(HL1MonsterPackConfig);

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
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction(RangedAttackAnims[Rand(4)]);
        bShotAnim = true;
    }
}

function FireProjectile()
{
	local Coords BoneLocation;
    local int i;
    local vector W,X,Y,Z, SpawnOffSet, FireStart;
    local Rotator R, Aim;

    if ( Controller != None)
    {
		BoneLocation = GetBoneCoords(FireProjBone);
		GetAxes(Rotation,X,Y,Z);
		SpawnOffSet = X;

		if(Rand(2) == 1)
		{
			Y *= -1;
        }

        for(i=0;i<6;i++)
        {
            FireStart = BoneLocation.Origin + 1 * SpawnOffSet + (Max(5,(2 * Rand(10))) * Y) + (Max(5,(2 * Rand(10))) * Z);
           	Aim = Controller.AdjustAim(SavedFireProperties,FireStart, 0);
           	W = Vector(Aim);
			R.Yaw = Spread * (FRand()-0.5);
			R.Pitch = Spread * (FRand()-0.5);
            R.Roll = Spread * (FRand()-0.5);
            Spawn(ProjectileClass[Rand(2)],self,,FireStart,Rotator(W >> R));
        }

		PlaySound(AttackSounds[Rand(4)],SLOT_Interact);
    }
}

simulated function SpawnAcidSpurt()
{
	local Coords BoneLocation;

	if ( Level.NetMode != NM_DedicatedServer )
	{
		BoneLocation = GetBoneCoords(FireProjBone);
		Spawn(class'PitDrone_Acid_spurt', self,,BoneLocation.Origin);
	}
}

event GainedChild(Actor Other)
{
    if(Other.Class == class'PitDrone_Projectile')
    {
        if ( Controller != None && Controller.Target != None)
        {
            if(bUseDamageConfig)
            {
                PitDrone_Projectile(Other).Damage = ProjectileDamage;
            }
        }
    }

  Super.GainedChild(Other);
}

defaultproperties
{
     Spread=1400.000000
     MeleeDamage=20.000000
     MeleeDamageBig=30.000000
     ProjectileDamage=15
     NewHealth=50
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_melee_attack1'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_melee_attack2'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_melee_attack1'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_melee_attack2'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_attack_spike1'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_attack_spike2'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_attack_spike1'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_attack_spike2'
     RangedAttackAnims(0)="Range"
     RangedAttackAnims(1)="Range"
     RangedAttackAnims(2)="Range"
     RangedAttackAnims(3)="Range"
     TauntAnim="Jump"
     MeleeAnims(0)="Bite"
     MeleeAnims(1)="Whip"
     MeleeAnims(2)="Bite"
     MeleeAnims(3)="Whip"
     HitAnims(0)="FlinchB"
     HitAnims(1)="FlinchS"
     HitAnims(2)="FlinchB"
     HitAnims(3)="FlinchS"
     DeathAnims(0)="Die02"
     DeathAnims(1)="Die03"
     DeathAnims(2)="Die02"
     DeathAnims(3)="Die03"
     FireProjBone="SpikeBone"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.PitDrone_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.PitDrone_Projectile'
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_pain4'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_die2'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_die3'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_die1'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_communicate1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_communicate2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_communicate1'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.PitDrone_Sounds.pit_drone_communicate3'
     ScoringValue=6
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_PitDrone'
     WallDodgeAnims(0)="TurnLeft"
     WallDodgeAnims(1)="TurnRight"
     WallDodgeAnims(2)="TurnLeft"
     WallDodgeAnims(3)="TurnRight"
     IdleHeavyAnim="Jump"
     IdleRifleAnim="Jump"
     FireHeavyRapidAnim="Run"
     FireHeavyBurstAnim="Run"
     FireRifleRapidAnim="Run"
     FireRifleBurstAnim="Run"
     MeleeRange=35.000000
     GroundSpeed=340.000000
     JumpZ=400.000000
     Health=50
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
     LandAnims(0)="Run"
     LandAnims(1)="Run"
     LandAnims(2)="Run"
     LandAnims(3)="Run"
     DodgeAnims(0)="TurnLeft"
     DodgeAnims(1)="TurnRight"
     DodgeAnims(2)="TurnLeft"
     DodgeAnims(3)="TurnRight"
     AirStillAnim="Run"
     TakeoffStillAnim="Run"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Jump"
     IdleSwimAnim="Jump"
     IdleWeaponAnim="Jump"
     IdleRestAnim="Jump"
     IdleChatAnim="Jump"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.PitDrone_Mesh'
     PrePivot=(Z=-30.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.PitDrone_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.PitDrone_Tex01'
     CollisionRadius=18.000000
     CollisionHeight=25.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.PitDrone.PawnKParams'

}
