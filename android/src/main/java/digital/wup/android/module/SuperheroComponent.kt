package digital.wup.android.module

import javax.inject.Singleton

import dagger.Component
import dagger.android.AndroidInjectionModule
import digital.wup.android.SuperheroApp
import digital.wup.android.module.detail.DetailActivityModule
import digital.wup.superhero.module.SuperheroModule
import digital.wup.superhero.module.character.CharacterActivityModule

@Singleton
@Component(modules = [(SuperheroModule::class), (CharacterActivityModule::class), (DetailActivityModule::class), (AndroidInjectionModule::class)])
interface SuperheroComponent {
    fun inject(application: SuperheroApp)
}
