package digital.wup.superheroapp.common.charaterdetail

import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.mvp.MvpPresenter
import digital.wup.superheroapp.common.mvp.MvpView

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