class Vortigaunt_Projectile_Trail extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=80.000000
         UseCrossedSheets=True
         PointLifeTime=0.800000
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScaleRepeats=-1.000000
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.800000),Y=(Max=0.700000),Z=(Min=0.100000,Max=0.100000))
         Opacity=0.600000
         MaxParticles=3
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=500.000000,Max=500.000000)
     End Object
     Emitters(0)=TrailEmitter'tk_HalfLife1MonsterPackv2.Vortigaunt_Projectile_Trail.TrailEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=25.000000,Max=50.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-2.500000,Max=6.000000),Y=(Min=-2.500000,Max=6.000000),Z=(Min=-2.500000,Max=6.000000))
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
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.750000,Max=0.750000),Z=(Min=0.100000,Max=0.100000))
         MaxParticles=15
         StartLocationOffset=(X=-5.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=1.000000)
         UseRotationFrom=PTRS_Normal
         SpinCCWorCW=(X=0.000000,Y=0.000000,Z=0.000000)
         StartSpinRange=(X=(Max=90.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=2.000000,Max=2.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(1)=BeamEmitter'tk_HalfLife1MonsterPackv2.Vortigaunt_Projectile_Trail.BeamEmitter1'

}
