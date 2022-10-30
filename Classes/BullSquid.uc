class BullSquid extends HalfLife_Monster config(HL1MonsterPackConfig);

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
    if(Other.Class == class'BullSquid_Projectile')
    {
        if ( Controller != None && Controller.Target != None)
        {
            if(bUseDamageConfig)
            {
                BullSquid_Projectile(Other).Damage = ProjectileDamage;
            }
        }
    }

  Super.GainedChild(Other);
}

defaultproperties
{
     MeleeDamage=18.000000
     MeleeDamageBig=25.000000
     RangedAttackIntervalTime=2.600000
     ProjectileDamage=15
     NewHealth=120
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_bite1'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_bite2'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_bite3'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_bite1'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_attack1'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_attack2'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_attack3'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_attack1'
     RangedAttackAnims(0)="Range"
     RangedAttackAnims(1)="Range"
     RangedAttackAnims(2)="Range"
     RangedAttackAnims(3)="Range"
     TauntAnim="SeeCrab"
     MeleeAnims(0)="Bite"
     MeleeAnims(1)="Whip"
     MeleeAnims(2)="Bite"
     MeleeAnims(3)="Whip"
     HitAnims(0)="FlinchB"
     HitAnims(1)="FlinchS"
     HitAnims(2)="FlinchB"
     HitAnims(3)="FlinchS"
     DeathAnims(0)="Die01"
     DeathAnims(1)="Die01"
     DeathAnims(2)="Die01"
     DeathAnims(3)="Die01"
     FireProjBone="SpitBone"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.BullSquid_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.BullSquid_Projectile'
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_pain4'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_die2'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_die3'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_die1'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_attackgrowl'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_attackgrowl2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_attackgrowl3'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.bc_attackgrowl'
     ScoringValue=5
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_BullSquid'
     WallDodgeAnims(0)="TurnLeft"
     WallDodgeAnims(1)="TurnRight"
     WallDodgeAnims(2)="TurnLeft"
     WallDodgeAnims(3)="TurnRight"
     IdleHeavyAnim="Idle"
     IdleRifleAnim="Idle"
     FireHeavyRapidAnim="Run"
     FireHeavyBurstAnim="Run"
     FireRifleRapidAnim="Run"
     FireRifleBurstAnim="Run"
     MeleeRange=30.000000
     GroundSpeed=400.000000
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
     LandAnims(0)="Run"
     LandAnims(1)="Run"
     LandAnims(2)="Run"
     LandAnims(3)="Run"
     DoubleJumpAnims(0)="Run"
     DoubleJumpAnims(1)="Run"
     DoubleJumpAnims(2)="Run"
     DoubleJumpAnims(3)="Run"
     DodgeAnims(0)="TurnLeft"
     DodgeAnims(1)="TurnRight"
     DodgeAnims(2)="TurnLeft"
     DodgeAnims(3)="TurnRight"
     AirStillAnim="Run"
     TakeoffStillAnim="Run"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Idle"
     IdleSwimAnim="Idle"
     IdleWeaponAnim="Idle"
     IdleRestAnim="Idle"
     IdleChatAnim="Idle"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.Bullsquid_Mesh'
     PrePivot=(Z=-27.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.Bullsquid_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.Bullsquid_Tex01'
     CollisionHeight=22.000000
     Mass=180.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.BullSquid.PawnKParams'

}
