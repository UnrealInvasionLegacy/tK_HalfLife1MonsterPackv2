class Vortigaunt_Electric_Hand extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseRevolution=True
         UseRevolutionScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseVelocityScale=True
         ColorScale(0)=(Color=(G=128,R=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=255,R=255))
         Opacity=0.500000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         SphereRadiusRange=(Min=1.000000,Max=5.000000)
         RevolutionsPerSecondRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         RevolutionScale(0)=(RelativeRevolution=(X=1.000000,Y=1.000000,Z=1.000000))
         RevolutionScale(1)=(RelativeTime=0.500000,RelativeRevolution=(X=1.000000,Y=1.000000,Z=1.000000))
         RevolutionScale(2)=(RelativeTime=1.000000)
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=20.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000))
         Texture=Texture'EpicParticles.Flares.Rev_Particle1'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.500000,Max=1.500000)
         StartVelocityRadialRange=(Min=150.000000,Max=300.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(Y=0.300000,Z=0.300000))
         VelocityScale(1)=(RelativeTime=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Vortigaunt_Electric_Hand.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseDirectionAs=PTDU_Up
         UseCollision=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.700000),Y=(Min=0.500000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=15.000000,Max=20.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.800000,RelativeSize=3.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'EpicParticles.Flares.OutSpark01aw'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRadialRange=(Min=-10.000000,Max=-10.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.400000,RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(2)=(RelativeTime=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Vortigaunt_Electric_Hand.SpriteEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=25.000000,Max=50.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=5.000000,Max=12.000000),Y=(Min=5.000000,Max=12.000000),Z=(Min=5.000000,Max=12.000000))
         LowFrequencyPoints=2
         HighFrequencyNoiseRange=(X=(Min=5.000000,Max=12.000000),Y=(Min=5.000000,Max=12.000000),Z=(Min=5.000000,Max=12.000000))
         HighFrequencyPoints=5
         BranchHFPointsRange=(Max=10000.000000)
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.600000),Y=(Min=0.700000),Z=(Min=0.100000,Max=0.100000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=15
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=1.000000,Max=1.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         LifetimeRange=(Min=0.200000,Max=0.500000)
         InitialDelayRange=(Min=0.500000,Max=0.800000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         StartVelocityRadialRange=(Min=100.000000,Max=150.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=BeamEmitter'tk_HalfLife1MonsterPackv2.Vortigaunt_Electric_Hand.BeamEmitter0'

}
