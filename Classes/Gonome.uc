class Gonome extends HalfLife_Monster config(HL1MonsterPackConfig);

var() Name AlternateWalkAnims[4];
var() bool bWalkAnimSet;

simulated function PostBeginPlay()
{
    local int i;

    Super.PostBeginPlay();

    if(fRand() > 0.5 && bWalkAnimSet)
    {
        bWalkAnimSet=true;
		for(i=0;i<4;i++)
		{
			MovementAnims[i] = AlternateWalkAnims[i];
			WallDodgeAnims[i] = AlternateWalkAnims[i];
			SwimAnims[i] = AlternateWalkAnims[i];
			CrouchAnims[i] = AlternateWalkAnims[i];
			WalkAnims[i] = AlternateWalkAnims[i];
			DodgeAnims[i] = AlternateWalkAnims[i];
		}

		TurnRightAnim = AlternateWalkAnims[0];
    	TurnLeftAnim = AlternateWalkAnims[0];
    	CrouchTurnRightAnim = AlternateWalkAnims[0];
		CrouchTurnLeftAnim = AlternateWalkAnims[0];
		FireHeavyRapidAnim = AlternateWalkAnims[0];
		FireHeavyBurstAnim = AlternateWalkAnims[0];
		FireRifleRapidAnim = AlternateWalkAnims[0];
		FireRifleBurstAnim = AlternateWalkAnims[0];
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

event GainedChild(Actor Other)
{
    if(Other.Class == class'Gonome_Projectile')
    {
        if ( Controller != None && Controller.Target != None)
        {
            if(bUseDamageConfig)
            {
                Gonome_Projectile(Other).Damage = ProjectileDamage;
            }
        }
    }

  Super.GainedChild(Other);
}

defaultproperties
{
     AlternateWalkAnims(0)="RunShort"
     AlternateWalkAnims(1)="RunShort"
     AlternateWalkAnims(2)="RunShort"
     AlternateWalkAnims(3)="RunShort"
     MeleeDamage=20.000000
     RangedAttackIntervalTime=4.200000
     NewHealth=70
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_melee1'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_melee2'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_melee1'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_melee2'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_eat'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_eat'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_eat'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_eat'
     RangedAttackAnims(0)="Attack03"
     RangedAttackAnims(1)="Attack03"
     RangedAttackAnims(2)="Attack03"
     RangedAttackAnims(3)="Attack03"
     TauntAnim="SoHappy"
     MeleeAnims(0)="Attack01"
     MeleeAnims(1)="Attack02"
     MeleeAnims(2)="Attack02"
     MeleeAnims(3)="Attack01"
     HitAnims(0)="Flinch"
     HitAnims(1)="Flinch"
     HitAnims(2)="Flinch"
     HitAnims(3)="Flinch"
     DeathAnims(0)="DieForward"
     DeathAnims(1)="DieBackward"
     DeathAnims(2)="DieForward"
     DeathAnims(3)="DieBackward"
     FireProjBone="FireBone"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.Gonome_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.Gonome_Projectile'
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_pain2'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_pain1'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_pain4'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_death2'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_death3'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_death4'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_death2'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_idle1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_idle2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_idle3'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.Gonome_Sounds.gonome_idle1'
     ScoringValue=10
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_Gonome'
     WallDodgeAnims(0)="RunLong"
     WallDodgeAnims(1)="RunLong"
     WallDodgeAnims(2)="RunLong"
     WallDodgeAnims(3)="RunLong"
     IdleHeavyAnim="Idle01"
     IdleRifleAnim="Idle01"
     FireHeavyRapidAnim="RunLong"
     FireHeavyBurstAnim="RunLong"
     FireRifleRapidAnim="RunLong"
     FireRifleBurstAnim="RunLong"
     MeleeRange=30.000000
     GroundSpeed=340.000000
     Health=70
     MovementAnims(0)="RunLong"
     MovementAnims(1)="RunLong"
     MovementAnims(2)="RunLong"
     MovementAnims(3)="RunLong"
     TurnLeftAnim="RunLong"
     TurnRightAnim="RunLong"
     SwimAnims(0)="RunLong"
     SwimAnims(1)="RunLong"
     SwimAnims(2)="RunLong"
     SwimAnims(3)="RunLong"
     CrouchAnims(0)="RunLong"
     CrouchAnims(1)="RunLong"
     CrouchAnims(2)="RunLong"
     CrouchAnims(3)="RunLong"
     WalkAnims(0)="RunLong"
     WalkAnims(1)="RunLong"
     WalkAnims(2)="RunLong"
     WalkAnims(3)="RunLong"
     AirAnims(0)="Jump01"
     AirAnims(1)="Jump01"
     AirAnims(2)="Jump01"
     AirAnims(3)="Jump01"
     TakeoffAnims(0)="Jump01"
     TakeoffAnims(1)="Jump01"
     TakeoffAnims(2)="Jump01"
     TakeoffAnims(3)="Jump01"
     LandAnims(0)="Jump01"
     LandAnims(1)="Jump01"
     LandAnims(2)="Jump01"
     LandAnims(3)="Jump01"
     DoubleJumpAnims(0)="Jump01"
     DoubleJumpAnims(1)="Jump01"
     DoubleJumpAnims(2)="Jump01"
     DoubleJumpAnims(3)="Jump01"
     DodgeAnims(0)="RunLong"
     DodgeAnims(1)="RunLong"
     DodgeAnims(2)="RunLong"
     DodgeAnims(3)="RunLong"
     AirStillAnim="Jump01"
     TakeoffStillAnim="Jump01"
     CrouchTurnRightAnim="RunLong"
     CrouchTurnLeftAnim="RunLong"
     IdleCrouchAnim="Idle01"
     IdleSwimAnim="Idle01"
     IdleWeaponAnim="Idle01"
     IdleRestAnim="Idle01"
     IdleChatAnim="Idle01"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.Gonome_Mesh'
     PrePivot=(Z=-53.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.Gonome_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.Gonome_Tex02'
     CollisionRadius=20.000000
     CollisionHeight=48.000000
     Mass=200.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.Gonome.PawnKParams'

}
