class Nihilanth_Projectile_Explode extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Max=0.800000),Y=(Max=0.700000))
         MaxParticles=2
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.400000)
     End Object
     Emitters(0)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Nihilanth_Projectile_Explode.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Right
         ProjectionNormal=(Z=0.000000)
         FadeOut=True
         RespawnDeadParticles=False
         UseRevolution=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorMultiplierRange=(X=(Max=0.800000),Y=(Max=0.600000))
         Opacity=0.700000
         MaxParticles=5
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=1.000000)
         RevolutionsPerSecondRange=(X=(Min=50.000000),Y=(Min=50.000000),Z=(Min=50.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'EmitterTextures.MultiFrame.LargeFlames-grey'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.400000,Max=0.500000)
         StartVelocityRadialRange=(Max=2.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=15.000000,Y=15.000000,Z=10.000000))
         VelocityScale(1)=(RelativeTime=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Nihilanth_Projectile_Explode.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseVelocityScale=True
         ColorMultiplierRange=(X=(Max=0.900000),Y=(Max=0.900000))
         Opacity=0.600000
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=5.000000)
         SpinsPerSecondRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=5.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=7.000000)
         StartSizeRange=(X=(Min=5.000000,Max=7.000000))
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=0.700000,Max=0.400000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=5.000000,Max=10.000000))
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=5.000000))
         VelocityScale(1)=(RelativeTime=0.500000,RelativeVelocity=(X=5.000000,Y=5.000000,Z=15.000000))
         WarmupTicksPerSecond=2.000000
         RelativeWarmupTime=1.000000
     End Object
     Emitters(2)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Nihilanth_Projectile_Explode.SpriteEmitter6'

}
