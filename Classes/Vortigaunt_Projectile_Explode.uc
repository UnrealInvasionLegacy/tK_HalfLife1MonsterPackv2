class Vortigaunt_Projectile_Explode extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.800000),Y=(Min=0.700000,Max=0.800000),Z=(Min=0.100000,Max=0.100000))
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=20.000000,Max=30.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.400000)
     End Object
     Emitters(0)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Vortigaunt_Projectile_Explode.SpriteEmitter18'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.800000),Y=(Min=0.600000,Max=0.800000),Z=(Min=0.100000,Max=0.100000))
         Opacity=0.500000
         MaxParticles=2
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000))
         StartLocationShape=PTLS_All
         SphereRadiusRange=(Min=10.000000,Max=15.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'EmitterTextures.MultiFrame.Effect_D'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
     End Object
     Emitters(1)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Vortigaunt_Projectile_Explode.SpriteEmitter19'

}
