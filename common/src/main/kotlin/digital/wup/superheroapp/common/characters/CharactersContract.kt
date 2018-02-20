package digital.wup.superheroapp.common.characters

import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.mvp.MvpPresenter
import digital.wup.superheroapp.common.mvp.MvpView

interface CharactersMvpPresenter : MvpPresenter {

    fun takeView(view: CharactersMvpView)

    fun dropView()

    fun loadCharacters()

    fun loadMoreCharacters()
}

interface CharactersMvpView : MvpView {

    fun showLoadingIndicator()

    fun hideLoadingIndicator()

    fun showMoreLoadingIndicator()

    fun hideMoreLoadingIndicator()

    fun showCharacters(characters: List<Character>)

    fun showLoadingCharactersError(message: String)

    fun showNoCharacters()
}