package digital.wup.superheroapp.charaterdetail

import digital.wup.superheroapp.characters.domain.model.Character
import digital.wup.superheroapp.mvp.MvpPresenter
import digital.wup.superheroapp.mvp.MvpView

interface CharacterDetailMvpPresenter : MvpPresenter {
    fun takeView(view: CharacterDetailMvpView)

    fun dropView()

    fun loadCharacter(characterId: Int)
}

interface CharacterDetailMvpView : MvpView {

    fun showCharacter(character: Character)

    fun showNoCharacter()

    fun showErrorMessage(message: String)
}