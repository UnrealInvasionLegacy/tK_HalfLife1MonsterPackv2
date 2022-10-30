class Voltigore_Projectile_Trail extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
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
         ColorMultiplierRange=(X=(Min=0.700000),Y=(Min=0.750000,Max=0.750000))
         CoordinateSystem=PTCS_Relative
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
         LifetimeRange=(Min=0.300000,Max=1.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(0)=BeamEmitter'tk_HalfLife1MonsterPackv2.Voltigore_Projectile_Trail.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=75.000000,Max=200.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-5.000000,Max=12.000000),Y=(Min=-5.000000,Max=12.000000),Z=(Min=-5.000000,Max=12.000000))
         LowFrequencyPoints=5
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=8.000000),Y=(Min=-5.000000,Max=8.000000),Z=(Min=-5.000000,Max=8.000000))
         HighFrequencyPoints=7
         HFScaleFactors(0)=(FrequencyScale=(X=2.000000,Y=2.000000,Z=2.000000),RelativeLength=0.500000)
         HFScaleFactors(1)=(FrequencyScale=(X=1.000000,Y=1.000000,Z=1.000000),RelativeLength=1.000000)
         BranchProbability=(Min=100.000000,Max=100.000000)
         BranchHFPointsRange=(Min=50.000000,Max=300.000000)
         BranchSpawnAmountRange=(Min=100.000000,Max=100.000000)
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorMultiplierRange=(X=(Min=0.700000),Y=(Min=0.750000,Max=0.750000))
         CoordinateSystem=PTCS_Relative
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
         LifetimeRange=(Min=0.300000,Max=1.000000)
         StartVelocityRange=(X=(Min=-10.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(1)=BeamEmitter'tk_HalfLife1MonsterPackv2.Voltigore_Projectile_Trail.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         UniformSize=True
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         StartSizeRange=(X=(Min=10.000000,Max=10.000000))
         Texture=Texture'AW-2004Particles.Energy.PurpleSwell'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Voltigore_Projectile_Trail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorMultiplierRange=(X=(Min=0.700000),Y=(Min=0.750000,Max=0.750000),Z=(Max=0.800000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000))
         Texture=Texture'AW-2004Particles.Energy.ElecPanels'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.200000,Max=0.300000)
     End Object
     Emitters(3)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Voltigore_Projectile_Trail.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorMultiplierRange=(X=(Max=0.700000),Y=(Min=0.750000,Max=0.750000))
         Opacity=0.100000
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=10.000000))
         Texture=Texture'AW-2004Particles.Weapons.PlasmaFlare'
         LifetimeRange=(Min=0.250000,Max=0.200000)
     End Object
     Emitters(4)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Voltigore_Projectile_Trail.SpriteEmitter3'

}
