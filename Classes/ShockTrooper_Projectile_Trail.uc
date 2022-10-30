class ShockTrooper_Projectile_Trail extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=15.000000,Max=45.000000)
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
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.000000),Y=(Min=0.750000,Max=0.750000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=15
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
         StartVelocityRange=(X=(Min=-10.000000))
     End Object
     Emitters(0)=BeamEmitter'tk_HalfLife1MonsterPackv2.ShockTrooper_Projectile_Trail.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UniformSize=True
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.000000),Y=(Min=0.750000,Max=0.750000))
         Opacity=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=10.000000,Max=10.000000))
         Texture=Texture'AW-2004Particles.Energy.AirBlast'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'tk_HalfLife1MonsterPackv2.ShockTrooper_Projectile_Trail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.000000),Y=(Min=0.750000,Max=0.750000))
         MaxParticles=20
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=5.000000)
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000))
         Texture=Texture'AW-2004Particles.Fire.MuchSmoke2t'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.200000,Max=0.100000)
     End Object
     Emitters(2)=SpriteEmitter'tk_HalfLife1MonsterPackv2.ShockTrooper_Projectile_Trail.SpriteEmitter1'

}
