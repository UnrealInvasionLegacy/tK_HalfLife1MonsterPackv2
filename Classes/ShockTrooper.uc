class ShockTrooper extends HalfLife_Monster config(HL1MonsterPackConfig);

//walk anim too long
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
    if(Other.Class == class'ShockTrooper_Projectile')
    {
        if ( Controller != None && Controller.Target != None)
        {
            if(bUseDamageConfig)
            {
                ShockTrooper_Projectile(Other).Damage = ProjectileDamage;
            }
        }
    }

  Super.GainedChild(Other);
}

defaultproperties
{
     MeleeDamage=20.000000
     RangedAttackIntervalTime=0.500000
     ProjectileDamage=25
     NewHealth=200
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_attack'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_attack'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_attack'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_attack'
     AttackSounds(0)=Sound'WeaponSounds.LinkGun.BLinkedFire'
     AttackSounds(1)=Sound'WeaponSounds.LinkGun.BLinkedFire'
     AttackSounds(2)=Sound'WeaponSounds.LinkGun.BLinkedFire'
     AttackSounds(3)=Sound'WeaponSounds.LinkGun.BLinkedFire'
     RangedAttackAnims(0)="Shoot"
     RangedAttackAnims(1)="Shoot"
     RangedAttackAnims(2)="Shoot"
     RangedAttackAnims(3)="Shoot"
     TauntAnim="Advance_Signal"
     MeleeAnims(0)="FrontKick"
     MeleeAnims(1)="FrontKick"
     MeleeAnims(2)="FrontKick"
     MeleeAnims(3)="FrontKick"
     HitAnims(0)="LeftArmFlinch"
     HitAnims(1)="LeftLegFlinch"
     HitAnims(2)="RightArmFlinch"
     HitAnims(3)="RightLegFlinch"
     DeathAnims(0)="DieBack01"
     DeathAnims(1)="DieBackwards"
     DeathAnims(2)="DieForwards"
     DeathAnims(3)="DieBackwards"
     FireProjBone="FireBone"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.ShockTrooper_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.ShockTrooper_Projectile'
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_pain4'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_die2'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_die3'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.shock_trooper_die1'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.hyu'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.thirv'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.puh'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.ShockTrooper_Sounds.mub'
     ScoringValue=10
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_ShockTrooper'
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
     MeleeRange=30.000000
     Health=200
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
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.ShockTrooper_Mesh'
     PrePivot=(Z=-50.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.ShockTrooper_Tex02'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.ShockTrooper_Tex03'
     Skins(2)=Texture'tk_HalfLife1MonsterPackv2.All.ShockTrooper_Tex01'
     CollisionRadius=20.000000
     CollisionHeight=45.000000
     Mass=250.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.ShockTrooper.PawnKParams'

}
