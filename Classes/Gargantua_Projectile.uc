class Gargantua_Projectile extends HalfLife_Projectile placeable;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();

    Velocity = Vector(Rotation) * Speed;
}

simulated event PhysicsVolumeChange( PhysicsVolume NewVolume )
{
    if (NewVolume.bWaterVolume)
    {
        Destroy();
    }

    Super.PhysicsVolumeChange(NewVolume);
}

simulated function Landed( vector HitNormal )
{
    SetPhysics(PHYS_Walking);
}

simulated function ProcessTouch( actor Other, vector HitLocation )
{
    if( !Other.bWorldGeometry && Other != Instigator )
    {
        Explode(HitLocation, Vect(0,0,1));
    }
}

simulated function HitWall( vector HitNormal, actor Wall )
{
    if ( Wall != Instigator && Pawn(Wall) != None || GameObjective(Wall) != None )
    {
        Explode(Location, HitNormal);
    }
}

defaultproperties
{
     TrailClass=Class'tk_HalfLife1MonsterPackv2.Gargantua_Projectile_Trail'
     ExplodeClass=Class'tk_HalfLife1MonsterPackv2.Gargantua_Projectile_Explode'
     Speed=500.000000
     MaxSpeed=7000.000000
     Damage=100.000000
     DamageRadius=20.000000
     MyDamageType=Class'tk_HalfLife1MonsterPackv2.DamType_Gargantua_Shock'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=255
     LightSaturation=127
     LightBrightness=100.000000
     LightRadius=4.000000
     CullDistance=4000.000000
     bDynamicLight=True
     Physics=PHYS_Falling
     AmbientSound=Sound'GeneralAmbience.firefx9'
     LifeSpan=4.000000
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=25.000000
     CollisionHeight=25.000000
}
