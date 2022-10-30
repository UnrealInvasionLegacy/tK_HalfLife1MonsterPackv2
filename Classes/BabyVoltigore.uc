class BabyVoltigore extends Voltigore config(HL1MonsterPackConfig);

function RangedAttack(Actor A)
{

	Super(HalfLife_Monster).RangedAttack(A);

    if( VSize(A.Location - Location) < MeleeRange + CollisionRadius + A.CollisionRadius )
    {
        Controller.bPreparingMove = true;
        Acceleration = vect(0,0,0);
        SetAnimAction(MeleeAnims[Rand(4)]);
        bShotAnim = true;
    }
}

defaultproperties
{
     MeleeDamage=30.000000
     MeleeDamageBig=40.000000
     NewHealth=300
     ScoringValue=5
     MeleeRange=60.000000
     GroundSpeed=425.000000
     Health=300
     DrawScale=0.500000
     PrePivot=(Z=-25.000000)
     Skins(0)=Texture'tk_HalfLife1MonsterPackv2.All.Voltigore_baby_Tex01'
     Skins(1)=Texture'tk_HalfLife1MonsterPackv2.All.Voltigore_baby_Tex02'
     CollisionRadius=25.000000
     CollisionHeight=22.500000
     Mass=300.000000
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
     KParams=KarmaParamsSkel'tk_HalfLife1MonsterPackv2.BabyVoltigore.PawnKParams'

}
