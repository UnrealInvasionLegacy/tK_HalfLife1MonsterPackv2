class Voltigore extends HalfLife_Monster config(HL1MonsterPackConfig);

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
    if(Other.Class == class'Voltigore_Projectile')
    {
        if ( Controller != None && Controller.Target != None)
        {
            if(bUseDamageConfig)
            {
                Voltigore_Projectile(Other).Damage = ProjectileDamage;
            }
        }
    }

  Super.GainedChild(Other);
}

defaultproperties
{
     MeleeDamage=60.000000
     MeleeDamageBig=80.000000
     RangedAttackIntervalTime=2.700000
     ProjectileDamage=50
     NewHealth=600
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_attack_melee1'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_attack_melee2'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_attack_melee1'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_attack_melee2'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_attack_shock'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_attack_shock'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_attack_shock'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_attack_shock'
     FootStepSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_footstep1'
     FootStepSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_footstep2'
     FootStepSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_footstep3'
     FootStepSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_footstep1'
     RangedAttackAnims(0)="DistanceAttack"
     RangedAttackAnims(1)="DistanceAttack"
     RangedAttackAnims(2)="DistanceAttack"
     RangedAttackAnims(3)="DistanceAttack"
     TauntAnim="VictorySniff"
     MeleeAnims(0)="MAttack01"
     MeleeAnims(1)="MAttack02"
     MeleeAnims(2)="MAttack01"
     MeleeAnims(3)="MAttack02"
     DeathAnims(0)="DieForward"
     DeathAnims(1)="DieSideways"
     DeathAnims(2)="DieSimple"
     DeathAnims(3)="DieForward"
     FireProjBone="FireBone"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.Voltigore_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.Voltigore_Projectile'
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_pain4'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_die2'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_die3'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_die1'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_alert1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_alert2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_alert3'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.Voltigore_Sounds.voltigore_alert1'
     ScoringValue=25
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_Voltigore'
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
     MeleeRange=70.000000
     GroundSpeed=375.000000
     Health=600
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
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.Voltigore_Mesh'
     PrePivot=(Z=-50.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.Voltigore_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.Voltigore_Tex02'
     CollisionRadius=50.000000
     CollisionHeight=45.000000
     Mass=600.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.Voltigore.PawnKParams'

}
