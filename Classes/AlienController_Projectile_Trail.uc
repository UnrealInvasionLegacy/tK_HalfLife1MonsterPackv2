class AlienController_Projectile_Trail extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=10.000000,Max=25.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-2.500000,Max=6.000000),Y=(Min=-2.500000,Max=6.000000),Z=(Min=-2.500000,Max=6.000000))
         LowFrequencyPoints=2
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         HighFrequencyPoints=3
         HFScaleFactors(0)=(FrequencyScale=(X=2.000000,Y=2.000000,Z=2.000000),RelativeLength=0.500000)
         HFScaleFactors(1)=(FrequencyScale=(X=1.000000,Y=1.000000,Z=1.000000),RelativeLength=1.000000)
         BranchProbability=(Min=100.000000,Max=100.000000)
         BranchHFPointsRange=(Min=50.000000,Max=300.000000)
         BranchSpawnAmountRange=(Min=100.000000,Max=100.000000)
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorMultiplierRange=(Y=(Max=0.900000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.700000
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=2.000000)
         UseRotationFrom=PTRS_Normal
         SpinCCWorCW=(X=0.000000,Y=0.000000,Z=0.000000)
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=1.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(0)=BeamEmitter'tk_HalfLife1MonsterPackv2.AlienController_Projectile_Trail.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
         StartSizeRange=(X=(Min=18.000000,Max=20.000000))
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=0.200000,Max=0.100000)
     End Object
     Emitters(1)=SpriteEmitter'tk_HalfLife1MonsterPackv2.AlienController_Projectile_Trail.SpriteEmitter1'

}
