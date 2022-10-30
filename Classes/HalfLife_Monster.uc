class HalfLife_Monster extends Monster;

#EXEC OBJ LOAD FILE=Resources\tk_HalfLife1MonsterPackv2_rc.usx PACKAGE=tk_HalfLife1MonsterPackv2

var() config bool bUseHealthConfig;
var() config bool bUseDamageConfig;

var() config float MeleeDamage;
var() config float MeleeDamageBig;
var() config float RangedAttackIntervalTime;
var() config int ProjectileDamage;
var() config bool bCanBeTeleFrag;

var() config int NewHealth;

var() Sound MeleeAttackSounds[4];
var() Sound MissSound[4];
var() Sound AttackSounds[4];
var() Sound FootStepSounds[4];

var() float MinTimeBetweenPainAnims;
var() float LastPainAnimTime;
var() float LastRangedAttackTime;

var() int AimError;

var() Name RangedAttackAnims[4];
var() Name TauntAnim;
var() Name MeleeAnims[4];
var() Name HitAnims[4];
var() Name DeathAnims[4];
var() Name FireProjBone;

var() class<Projectile> ProjectileClass[2];


//ragdoll
var() config float KillingForce;
var() config float UpKickForce;
var() config bool bHasRagdoll;

/*replication
{
    reliable if(Role == Role_Authority)
        bHasRagdoll;
}*/

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    if(Role == ROLE_Authority)
    {
        if(bUseHealthConfig)
        {
            Health = NewHealth;
        }
    }
}

event EncroachedBy( actor Other )
{
    if(bCanBeTeleFrag)
    {
        Super.EncroachedBy(Other);
    }
}

function MeleeAttack()
{
    if(Controller != None && Controller.Target != None)
    {
        if (MeleeDamageTarget(MeleeDamage, (30000 * Normal(Controller.Target.Location - Location))) )
        {
            PlaySound(MeleeAttackSounds[Rand(4)], SLOT_Interact);
        }
        else
        {
            PlaySound(MissSound[Rand(4)], SLOT_Interact);
        }
    }
}

function MeleeAttackStrong()
{
    if(Controller != None && Controller.Target != None)
    {
        if (MeleeDamageTarget(MeleeDamageBig, (30000 * Normal(Controller.Target.Location - Location))) )
        {
            PlaySound(MeleeAttackSounds[Rand(4)], SLOT_Interact);
        }
        else
        {
            PlaySound(MissSound[Rand(4)], SLOT_Interact);
        }
    }
}

function RangedAttack(Actor A)
{
    if(bShotAnim || A == None || Controller == None)
    {
        return;
    }
}

simulated function Destroyed()
{
    RemoveEffects();
    Super.Destroyed();
}

simulated function RemoveEffects()
{

}

simulated function PlayDirectionalDeath(Vector HitLoc)
{
    PlayAnim(DeathAnims[Rand(4)],, 0.1);
}

function PlayMoverHitSound()
{
    PlaySound(HitSound[0], SLOT_Interact);
}

function bool SameSpeciesAs(Pawn P)
{
    return ( (Monster(P) != None) && Monster(P).Controller != None && (!Monster(P).Controller.IsA('FriendlyMonsterController')));
}

function PlayTakeHit(vector HitLocation, int Damage, class<DamageType> DamageType)
{
    if( Level.TimeSeconds - LastPainAnimTime < MinTimeBetweenPainAnims )
    {
        LastPainAnimTime = Level.TimeSeconds;
        PlayDirectionalHit(HitLocation);
    }

    if( Level.TimeSeconds - LastPainSound < MinTimeBetweenPainSounds )
    {
        return;
    }

    LastPainSound = Level.TimeSeconds;
    PlaySound(HitSound[Rand(4)], SLOT_Pain,2*TransientSoundVolume,,400);
}

simulated function PlayDirectionalHit(Vector HitLoc)
{
    local Name Anim;

    Anim = HitAnims[Rand(4)];

    if(Anim != 'None')
    {
        PlayAnim(HitAnims[Rand(4)],, 0.1);
    }
}

function FireProjectile()
{
    local Coords BoneLocation;
    local Projectile Proj;

    if ( Controller != None)
    {
        BoneLocation = GetBoneCoords(FireProjBone);
        Proj = Spawn(ProjectileClass[Rand(2)],Self,,BoneLocation.Origin,Controller.AdjustAim(SavedFireProperties,BoneLocation.Origin,AimError));

        if(Proj != None)
        {
            PlaySound(AttackSounds[Rand(4)],SLOT_Interact);
        }
    }
}

function PlayVictoryAnimation()
{
    Controller.bPreparingMove = true;
    Acceleration = vect(0,0,0);
    SetAnimAction(TauntAnim);
}

simulated function RunStep()
{
   PlaySound(FootStepSounds[Rand(4)], SLOT_Interact, FootStepVolume);
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{

    if(!bCanBeTeleFrag && DamageType != None && ClassIsChildOf(DamageType,class'DamTypeRoadkill'))
    {
        Damage = 0;
    }

   Super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}


simulated function PlayDying(class<DamageType> DamageType, vector HitLoc)
{
    local vector shotDir, hitLocRel, deathAngVel, shotStrength;
    local float maxDim, frame, rate;
    local string RagSkelName;
    local KarmaParamsSkel skelParams;
    local name seq;
    local bool PlayersRagdoll;
    local PlayerController pc;
    local LavaDeath LD;

    /*if(!bHasRagdoll)
    {
        Super.PlayDying(DamageType, HitLoc);
    }*/

    AmbientSound = None;
    bCanTeleport = false; // sjs - fix karma going crazy when corpses land on teleporters
    bReplicateMovement = false;
    bTearOff = true;
    bPlayedDeath = true;

    if (CurrentCombo != None)
        CurrentCombo.Destroy();

    HitDamageType = DamageType; // these are replicated to other clients
    TakeHitLocation = HitLoc;

    if ( (DamageType != None) && DamageType.default.bSkeletize && (SkeletonMesh != None) )
    {
        if (!bSkeletized)
        {
            GetAnimParams( 0, seq, frame, rate );
            LinkMesh(SkeletonMesh, true);
            Skins.Length = 0;
            PlayAnim(seq, 0, 0);
            SetAnimFrame(frame);
            if (Physics == PHYS_Walking)
                Velocity = Vect(0,0,0);
            TearOffMomentum *= 0.25;
            bSkeletized = true;

            if(DamageType == class'FellLava')
            {
                LD = spawn(class'LavaDeath');
                if ( LD != None )
                {
                    LD.SetLocation(Location);
                    LD.SetRotation(Rotation);
                    LD.SetBase(self);
                }
                // This should destroy itself once its finished.

                PlaySound( sound'WeaponSounds.BExplosion5', SLOT_None, 1.5*TransientSoundVolume );
            }
        }
    }

    // stop shooting
    AnimBlendParams(1, 0.0);
    FireState = FS_None;
    LifeSpan = RagdollLifeSpan;

    GotoState('Dying');

    if ( Level.NetMode != NM_DedicatedServer && bHasRagdoll)
    {
        // Is this the local player's ragdoll?
        if(OldController != None)
            pc = PlayerController(OldController);
        if( pc != None && pc.ViewTarget == self )
            PlayersRagdoll = true;

        // In low physics detail, if we were not just controlling this pawn,
        // and it has not been rendered in 3 seconds, just destroy it.
        if(Level.PhysicsDetailLevel == PDL_Low && !PlayersRagdoll && (Level.TimeSeconds - LastRenderTime > 3) )
        {
            Destroy();
            return;
        }

        // Try and obtain a rag-doll setup
        if(Species != None)
            RagSkelName = Species.static.GetRagSkelName(GetMeshName());
        else
            Log("xPawn.PlayDying: No Species");


        // If we managed to find a name, try and make a rag-doll slot availbale.
        if( RagSkelName != "" )
        {
            KMakeRagdollAvailable();
        }

        if( KIsRagdollAvailable() && RagSkelName != "" )
        {
            skelParams = KarmaParamsSkel(KParams);
            skelParams.KSkeleton = RagSkelName;
            KParams = skelParams;
            //Log("RAGDOLL");

            // Stop animation playing.
            StopAnimating(true);

            if(DamageType != None)
            {

//IMPORTANT: Normally the code was written here as if(DamageType != None && DamageType.default.bKUseOwnDeathVel). This wants to say
//that normally the impact strength would only be changed if you're having a weapon that can be charged
//as the Shield Hammer. For e.g. Rockets there wouldn't have been any change.
//Simply change this line back if you'd like to have the original code
//KillingForce is the configurable value, standard: 10

                RagDeathVel = KillingForce;
                RagDeathUpKick = UpKickForce;
            }

            // Set the dude moving in direction he was shot in general
            shotDir = Normal(TearOffMomentum);
            shotStrength = RagDeathVel * shotDir;

            // Calculate angular velocity to impart, based on shot location.
            hitLocRel = TakeHitLocation - Location;

            // We scale the hit location out sideways a bit, to get more spin around Z.
            hitLocRel.X *= RagSpinScale;
            hitLocRel.Y *= RagSpinScale;
            deathAngVel = RagInvInertia * (hitLocRel Cross shotStrength);

            // Set initial angular and linear velocity for ragdoll.
            // Scale horizontal velocity for characters - they run really fast!
            skelParams.KStartLinVel.X = 0.6 * Velocity.X;
            skelParams.KStartLinVel.Y = 0.6 * Velocity.Y;
            skelParams.KStartLinVel.Z = 1.0 * Velocity.Z;
            skelParams.KStartLinVel += shotStrength;

            // If not moving downwards - give extra upward kick
            if(Velocity.Z > -10)
                skelParams.KStartLinVel.Z += RagDeathUpKick;

            skelParams.KStartAngVel = deathAngVel;

            // Set up deferred shot-bone impulse
            maxDim = Max(CollisionRadius, CollisionHeight);

            skelParams.KShotStart = TakeHitLocation - (1 * shotDir);
            skelParams.KShotEnd = TakeHitLocation + (2*maxDim*shotDir);
            skelParams.KShotStrength = 10;

            // If this damage type causes convulsions, turn them on here.
            if(DamageType != None && DamageType.default.bCauseConvulsions)
            {
                RagConvulseMaterial=DamageType.default.DamageOverlayMaterial;
                skelParams.bKDoConvulsions = true;
            }

            // Turn on Karma collision for ragdoll.
            KSetBlockKarma(true);

            // Set physics mode to ragdoll.
            // This doesn't actaully start it straight away, it's deferred to the first tick.
            SetPhysics(PHYS_KarmaRagdoll);
            // If viewing this ragdoll, set the flag to indicate that it is 'important'
            if( PlayersRagdoll )
                skelParams.bKImportantRagdoll = true;

            return;
        }
        // jag
    }

    // non-ragdoll death fallback
    Velocity += TearOffMomentum;
    BaseEyeHeight = Default.BaseEyeHeight;
    SetTwistLook(0, 0);
    SetInvisibility(0.0);
    PlayDirectionalDeath(HitLoc);
    SetPhysics(PHYS_Falling);
}

defaultproperties
{
     bUseHealthConfig=True
     bUseDamageConfig=True
     MeleeDamage=8.000000
     MeleeDamageBig=12.000000
     RangedAttackIntervalTime=3.000000
     ProjectileDamage=20
     bCanBeTeleFrag=True
     NewHealth=100
     MissSound(0)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.HL_miss_01'
     MissSound(1)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.HL_miss_02'
     MissSound(2)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.HL_miss_01'
     MissSound(3)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.HL_miss_02'
     FootStepSounds(0)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.HL_Footstep_01'
     FootStepSounds(1)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.HL_Footstep_02'
     FootStepSounds(2)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.HL_Footstep_01'
     FootStepSounds(3)=Sound'tk_HalfLife1MonsterPackv2.Bullsquid_Sounds.HL_Footstep_02'
     MinTimeBetweenPainAnims=3.000000
     aimerror=10
     KillingForce=200.000000
     UpKickForce=300.000000
     DodgeSkillAdjust=1.000000
     bCanWalkOffLedges=True
}
