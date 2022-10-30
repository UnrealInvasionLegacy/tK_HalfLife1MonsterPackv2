class Grunt extends HalfLife_Monster config(HL1MonsterPackConfig);

var() float Spread;
var() config bool bHornetCanLock;
var() config int NumHornetBounces;
var() config bool bHornetCanBounceCorners;

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

		FireStart = BoneLocation.Origin + 1 * SpawnOffSet + (Max(5,(2 * Rand(5))) * Y) + (Max(5,(2 * Rand(5))) * Z);
		Aim = Controller.AdjustAim(SavedFireProperties,FireStart, 0);
		W = Vector(Aim);
		R.Yaw = Spread * (FRand()-0.5);
		R.Pitch = Spread * (FRand()-0.5);
		R.Roll = Spread * (FRand()-0.5);
		Spawn(ProjectileClass[Rand(2)],self,,FireStart,Rotator(W >> R));

		PlaySound(AttackSounds[Rand(4)],SLOT_Interact);
	}
}

event GainedChild(Actor Other)
{
    if(Other.Class == class'Grunt_Projectile')
    {
        if ( Controller != None && Controller.Target != None)
        {
            Grunt_Projectile(Other).bHornetCanLock = bHornetCanLock;
            Grunt_Projectile(Other).Seeking = Controller.Target;
            Grunt_Projectile(Other).NumHornetBounces = NumHornetBounces;
			Grunt_Projectile(Other).bHornetCanBounceCorners = bHornetCanBounceCorners;

            if(bUseDamageConfig)
            {
                Grunt_Projectile(Other).Damage = ProjectileDamage;
            }
        }
    }

  Super.GainedChild(Other);
}

defaultproperties
{
     Spread=1400.000000
     bHornetCanLock=True
     NumHornetBounces=1
     bHornetCanBounceCorners=True
     MeleeDamage=20.000000
     NewHealth=120
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_attack1'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_attack2'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_attack3'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_attack1'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_fire1'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_fire2'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_fire3'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_fire1'
     RangedAttackAnims(0)="Attack01"
     RangedAttackAnims(1)="Attack01"
     RangedAttackAnims(2)="LongShoot01"
     RangedAttackAnims(3)="QuickShoot01"
     TauntAnim="Scare"
     MeleeAnims(0)="Attack02"
     MeleeAnims(1)="Attack03"
     MeleeAnims(2)="Attack02"
     MeleeAnims(3)="Attack03"
     HitAnims(0)="LArmFlinch"
     HitAnims(1)="LLegFlinch"
     HitAnims(2)="RArmFlinch"
     HitAnims(3)="RLegFlinch"
     DeathAnims(0)="DieBackwards"
     DeathAnims(1)="DieForwards"
     DeathAnims(2)="DieHead"
     DeathAnims(3)="DieBackwards"
     FireProjBone="FireBone"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.Grunt_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.Grunt_Projectile'
     bCanDodge=False
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_pain4'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_die2'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_die3'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_die4'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_alert1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_alert2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_alert3'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.AlienGrunt_Sounds.ag_alert5'
     ScoringValue=12
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_Grunt'
     WallDodgeAnims(0)="Run"
     WallDodgeAnims(1)="Run"
     WallDodgeAnims(2)="Run"
     WallDodgeAnims(3)="Run"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Run"
     FireHeavyBurstAnim="Run"
     FireRifleRapidAnim="Run"
     FireRifleBurstAnim="Run"
     bCanJump=False
     MeleeRange=30.000000
     GroundSpeed=340.000000
     Health=120
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
     LandAnims(0)="LandHard"
     LandAnims(1)="LandHard"
     LandAnims(2)="LandHard"
     LandAnims(3)="LandHard"
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
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.AlienGrunt_Mesh'
     DrawScale=1.500000
     PrePivot=(Z=-65.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.AlienGrunt_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.AlienGrunt_Tex02'
     CollisionRadius=45.000000
     CollisionHeight=60.000000
     Mass=500.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.Grunt.PawnKParams'

}
