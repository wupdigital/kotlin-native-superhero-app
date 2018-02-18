package digital.wup.superheroapp.characters

import digital.wup.superheroapp.characters.domain.model.Character
import digital.wup.superheroapp.mvp.MvpPresenter
import digital.wup.superheroapp.mvp.MvpView

interface CharactersMvpPresenter: MvpPresenter {

    fun takeView(view: CharactersMvpView)

    fun dropView()

    fun characters(): List<Character>

    fun charactersCount(): Int

    fun loadCharacters()

    fun loadMoreCharacters()
}

interface CharactersMvpView: MvpView {

    fun showLoadingIndicator()

    fun hideLoadingIndicator()

    fun showMoreLoadingIndicator()

    fun hideMoreLoadingIndicator()

    fun refreshCharacters()

    fun showLoadingCharactersError(message: String)

    fun showNoCharacters()
}