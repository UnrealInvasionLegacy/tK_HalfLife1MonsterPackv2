class Gargantua_Flame extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255))
         ColorScale(1)=(RelativeTime=0.500000)
         ColorScale(2)=(RelativeTime=1.000000)
         Opacity=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=75
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=5.000000,Max=10.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000))
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=1.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=250.000000,Max=200.000000))
     End Object
     Emitters(0)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Gargantua_Flame.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=23,G=151,R=244))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=192,G=192,R=192))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=102,G=152,R=255))
         Opacity=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=250
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=5.000000,Max=10.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.250000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000))
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=1.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=250.000000,Max=200.000000))
     End Object
     Emitters(1)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Gargantua_Flame.SpriteEmitter2'

}
