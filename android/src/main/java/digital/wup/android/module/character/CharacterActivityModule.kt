package digital.wup.superhero.module.character

import android.app.Activity

import dagger.Binds
import dagger.Module
import dagger.android.ActivityKey
import dagger.android.AndroidInjector
import dagger.multibindings.IntoMap
import digital.wup.android.presentation.ui.characters.CharactersActivity


@Module(subcomponents = arrayOf(CharacterActivitySubcomponent::class))
abstract class CharacterActivityModule {
    @Binds
    @IntoMap
    @ActivityKey(CharactersActivity::class)
    internal abstract fun bindSuperheroActivityInjectorFactory(builder: CharacterActivitySubcomponent.Builder): AndroidInjector.Factory<out Activity>
}
