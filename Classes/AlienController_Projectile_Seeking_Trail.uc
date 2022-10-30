class AlienController_Projectile_Seeking_Trail extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorMultiplierRange=(Y=(Max=0.700000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.200000
         MaxParticles=20
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=2.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=27.000000,Max=32.000000))
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=0.200000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'tk_HalfLife1MonsterPackv2.AlienController_Projectile_Seeking_Trail.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         Opacity=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=35.000000,Max=40.000000))
         Texture=Texture'AW-2004Particles.Fire.SmallBang'
         LifetimeRange=(Min=0.100000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'tk_HalfLife1MonsterPackv2.AlienController_Projectile_Seeking_Trail.SpriteEmitter3'

}
