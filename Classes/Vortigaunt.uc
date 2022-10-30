class Vortigaunt extends HalfLife_Monster config(HL1MonsterPackConfig);

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

simulated function HandsGlow()
{
	local Coords BoneLocation;
	local Emitter LHandFX, RHandFX;

	if ( Level.NetMode != NM_DedicatedServer )
	{
		BoneLocation = GetBoneCoords('rhand');
		RHandFX = Spawn(class'Vortigaunt_Electric_Hand', self,,BoneLocation.Origin);
		AttachToBone(RHandFX,'rhand');

		BoneLocation = GetBoneCoords('lhand');
		LHandFX = Spawn(class'Vortigaunt_Electric_Hand', self,,BoneLocation.Origin);
		AttachToBone(LHandFX,'lhand');
	}
}

event GainedChild(Actor Other)
{
    if(Other.Class == class'Vortigaunt_Projectile')
    {
        if ( Controller != None && Controller.Target != None)
        {
            if(bUseDamageConfig)
            {
                Vortigaunt_Projectile(Other).Damage = ProjectileDamage;
            }
        }
    }

  Super.GainedChild(Other);
}

defaultproperties
{
     MeleeDamage=15.000000
     ProjectileDamage=35
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_word2'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_word3'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_word4'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_word5'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_word6'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_word7'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_word8'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_word1'
     RangedAttackAnims(0)="ZapAttack"
     RangedAttackAnims(1)="ZapAttack"
     RangedAttackAnims(2)="ZapAttack"
     RangedAttackAnims(3)="ZapAttack"
     TauntAnim="Grab"
     MeleeAnims(0)="Attack01"
     MeleeAnims(1)="Attack01"
     MeleeAnims(2)="Attack01"
     MeleeAnims(3)="Attack01"
     HitAnims(0)="RLFlinch"
     HitAnims(1)="RAFlinch"
     HitAnims(2)="LLFlinch"
     HitAnims(3)="LAFlinch"
     DeathAnims(0)="DieBackwards"
     DeathAnims(1)="DieForwards"
     DeathAnims(2)="DieHeadShot"
     DeathAnims(3)="DieSimple"
     FireProjBone="FireBone"
     ProjectileClass(0)=Class'tk_HalfLife1MonsterPackv2.Vortigaunt_Projectile'
     ProjectileClass(1)=Class'tk_HalfLife1MonsterPackv2.Vortigaunt_Projectile'
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_pain1'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_pain2'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_die2'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_die1'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_die2'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_alert1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_word1'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_alert3'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.AlienSlave_Sounds.slv_alert1'
     ScoringValue=8
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_Vortigaunt'
     WallDodgeAnims(0)="Left"
     WallDodgeAnims(1)="Right"
     WallDodgeAnims(2)="Left"
     WallDodgeAnims(3)="Right"
     IdleHeavyAnim="Idle03"
     IdleRifleAnim="Idle03"
     FireHeavyRapidAnim="Run"
     FireHeavyBurstAnim="Run"
     FireRifleRapidAnim="Run"
     FireRifleBurstAnim="Run"
     MeleeRange=30.000000
     GroundSpeed=340.000000
     JumpZ=300.000000
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
     DodgeAnims(0)="Left"
     DodgeAnims(1)="Right"
     DodgeAnims(2)="Left"
     DodgeAnims(3)="Right"
     AirStillAnim="Run"
     TakeoffStillAnim="Run"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Idle03"
     IdleSwimAnim="Idle03"
     IdleWeaponAnim="Idle03"
     IdleRestAnim="Idle03"
     IdleChatAnim="Idle03"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.AlienSlave_Mesh'
     DrawScale=1.500000
     PrePivot=(Z=-45.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.AlienSlave_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.AlienSlave_Tex01'
     CollisionRadius=28.000000
     CollisionHeight=42.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.Vortigaunt.PawnKParams'

}
