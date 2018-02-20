package digital.wup.superhero.module.character

import dagger.Subcomponent
import dagger.android.AndroidInjector
import digital.wup.android.presentation.ui.characters.CharactersActivity

@Subcomponent
interface CharacterActivitySubcomponent : AndroidInjector<CharactersActivity> {
    @Subcomponent.Builder
    abstract class Builder : AndroidInjector.Builder<CharactersActivity>()
}
