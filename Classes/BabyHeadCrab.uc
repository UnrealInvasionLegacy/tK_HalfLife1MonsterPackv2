class BabyHeadCrab extends HalfLife_Monster config(HL1MonsterPackConfig);

var() bool bLunging;

singular function Bump(actor Other)
{
    local name Anim;
    local float frame,rate;
    local int i;

    if ( bShotAnim && bLunging )
    {
        bLunging = false;
        GetAnimParams(0, Anim,frame,rate);
        for(i=0;i<4;i++)
        {
			if( Anim == MeleeAnims[i] )
			{
				MeleeAttack();
				break;
			}
		}
    }

    Super.Bump(Other);
}

function SetMovementPhysics()
{
    SetPhysics(PHYS_Falling);
}

function RangedAttack(Actor A)
{
    local float Dist;

    if ( bShotAnim )
        return;

    Dist = VSize(A.Location - Location);
    if ( Dist > 350 )
        return;
    bShotAnim = true;
    PlaySound(ChallengeSound[Rand(4)], SLOT_Interact);
    if ( Dist < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        SetAnimAction('Jump01');
		MeleeAttack();
		Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        return;
    }

    bLunging = true;
    Enable('Bump');
    SetAnimAction(MeleeAnims[Rand(4)]);
    Velocity = 500 * Normal(A.Location + A.CollisionHeight * vect(0,0,0.75) - Location);
    if ( dist > CollisionRadius + A.CollisionRadius + 35 )
    {
        Velocity.Z += 0.7 * dist;
	}

    SetPhysics(PHYS_Falling);
}

defaultproperties
{
     MeleeDamage=10.000000
     NewHealth=20
     MeleeAttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_attack1'
     MeleeAttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_attack2'
     MeleeAttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_attack3'
     MeleeAttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_attack1'
     AttackSounds(0)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_attack1'
     AttackSounds(1)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_attack2'
     AttackSounds(2)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_attack3'
     AttackSounds(3)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_attack1'
     TauntAnim="Angry"
     MeleeAnims(0)="Jump01"
     MeleeAnims(1)="Jump02"
     MeleeAnims(2)="Jump03"
     MeleeAnims(3)="Jump01"
     HitAnims(0)="Flinch"
     HitAnims(1)="Flinch"
     HitAnims(2)="Flinch"
     HitAnims(3)="Flinch"
     DeathAnims(0)="DieBack"
     DeathAnims(1)="DieBack"
     DeathAnims(2)="DieBack"
     DeathAnims(3)="DieBack"
     bAlwaysStrafe=True
     HitSound(0)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_pain1'
     HitSound(1)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_pain2'
     HitSound(2)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_pain3'
     HitSound(3)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_pain1'
     DeathSound(0)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_die1'
     DeathSound(1)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_die2'
     DeathSound(2)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_die1'
     DeathSound(3)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_die2'
     ChallengeSound(0)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_alert1'
     ChallengeSound(1)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_alert2'
     ChallengeSound(2)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_idle3'
     ChallengeSound(3)=Sound'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Sounds.hc_idle1'
     Species=Class'tk_HalfLife1MonsterPackv2.SPECIES_BabyHeadCrab'
     WallDodgeAnims(0)="180Left"
     WallDodgeAnims(1)="180Right"
     WallDodgeAnims(2)="180Left"
     WallDodgeAnims(3)="180Right"
     IdleHeavyAnim="Idle03"
     IdleRifleAnim="Idle03"
     FireHeavyRapidAnim="Run"
     FireHeavyBurstAnim="Run"
     FireRifleRapidAnim="Run"
     FireRifleBurstAnim="Run"
     bCrawler=True
     MeleeRange=50.000000
     GroundSpeed=400.000000
     JumpZ=420.000000
     Health=20
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
     DodgeAnims(0)="180Left"
     DodgeAnims(1)="180Right"
     DodgeAnims(2)="180Left"
     DodgeAnims(3)="180Right"
     AirStillAnim="Run"
     TakeoffStillAnim="Run"
     CrouchTurnRightAnim="Run"
     CrouchTurnLeftAnim="Run"
     IdleCrouchAnim="Idle03"
     IdleSwimAnim="Idle03"
     IdleWeaponAnim="Idle03"
     IdleRestAnim="Idle03"
     IdleChatAnim="Idle03"
     Mesh=SkeletalMesh'tk_HalfLife1MonsterPackv2.BabyHeadCrab_Mesh'
     DrawScale=1.500000
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.BabyHeadCrab_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.BabyHeadCrab_Tex01'
     CollisionRadius=10.000000
     CollisionHeight=5.000000
     Mass=80.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.BabyHeadCrab.PawnKParams'

}
