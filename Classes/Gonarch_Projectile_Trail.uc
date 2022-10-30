class Gonarch_Projectile_Trail extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         ColorMultiplierRange=(Y=(Max=0.900000))
         Opacity=0.500000
         MaxParticles=30
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=5.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=15.000000,Max=25.000000))
         ParticlesPerSecond=20.000000
         Texture=Texture'EmitterTextures.SingleFrame.FlamePart_02'
         LifetimeRange=(Min=0.200000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Gonarch_Projectile_Trail.SpriteEmitter0'

}
