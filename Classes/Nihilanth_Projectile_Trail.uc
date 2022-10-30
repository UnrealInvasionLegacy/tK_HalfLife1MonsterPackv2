class Nihilanth_Projectile_Trail extends HalfLife_Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Max=0.800000))
         Opacity=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Max=2.000000)
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=0.200000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Nihilanth_Projectile_Trail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         ColorMultiplierRange=(X=(Max=0.800000),Y=(Min=0.700000,Max=0.800000))
         Opacity=0.200000
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=25.000000,Max=30.000000))
         Texture=Texture'EmitterTextures.MultiFrame.LargeFlames-grey'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.300000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'tk_HalfLife1MonsterPackv2.Nihilanth_Projectile_Trail.SpriteEmitter3'

}
