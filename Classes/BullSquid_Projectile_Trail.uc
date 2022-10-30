class BullSquid_Projectile_Trail extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UniformSize=True
         ColorScale(0)=(Color=(B=128,G=128,R=128))
         ColorScale(1)=(RelativeTime=0.100000,Color=(G=128,R=128))
         ColorScale(2)=(RelativeTime=0.500000,Color=(B=6,G=57,R=32))
         ColorScale(3)=(RelativeTime=1.000000)
         ColorMultiplierRange=(X=(Max=0.700000),Y=(Min=2.000000,Max=2.000000),Z=(Min=0.500000,Max=0.200000))
         Opacity=0.500000
         MaxParticles=30
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=5.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.200000)
         StartSizeRange=(X=(Min=5.000000,Max=15.000000))
         ParticlesPerSecond=20.000000
         Texture=Texture'EmitterTextures.SingleFrame.FlamePart_02'
         LifetimeRange=(Min=0.200000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'tk_HalfLife1MonsterPackv2.BullSquid_Projectile_Trail.SpriteEmitter0'

}
