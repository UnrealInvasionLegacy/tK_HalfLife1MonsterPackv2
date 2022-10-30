class Voltigore_Projectile_Explode extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.700000),Y=(Min=0.750000,Max=0.750000))
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.400000)
     End Object
     Emitters(0)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Voltigore_Projectile_Explode.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorMultiplierRange=(X=(Min=0.700000),Y=(Min=0.750000,Max=0.750000))
         Opacity=0.300000
         MaxParticles=2
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000))
         StartLocationShape=PTLS_All
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'AW-2004Particles.Energy.JumpDuck'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
     End Object
     Emitters(1)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Voltigore_Projectile_Explode.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.000000),Z=(Max=0.800000))
         MaxParticles=20
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=1.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'EpicParticles.Flares.OutSpark04aw'
         LifetimeRange=(Min=0.800000,Max=1.000000)
         StartVelocityRadialRange=(Min=2.000000,Max=10.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=20.000000,Y=20.000000,Z=20.000000))
         VelocityScale(1)=(RelativeTime=0.800000,RelativeVelocity=(X=5.000000,Y=5.000000,Z=5.000000))
     End Object
     Emitters(2)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Voltigore_Projectile_Explode.SpriteEmitter6'

}
