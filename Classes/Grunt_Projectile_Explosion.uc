class Grunt_Projectile_Explosion extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseVelocityScale=True
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.000000),Z=(Min=0.200000,Max=0.200000))
         Opacity=0.500000
         MaxParticles=5
         SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=5.000000,Max=10.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=0.200000,Max=0.500000)
         StartVelocityRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=3.000000,Max=-3.000000),Z=(Min=-3.000000,Max=-3.000000))
         VelocityScale(0)=(RelativeVelocity=(X=8.000000,Y=8.000000,Z=8.000000))
         VelocityScale(1)=(RelativeTime=1.000000,RelativeVelocity=(X=10.000000,Y=10.000000,Z=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Grunt_Projectile_Explosion.SpriteEmitter0'

}
