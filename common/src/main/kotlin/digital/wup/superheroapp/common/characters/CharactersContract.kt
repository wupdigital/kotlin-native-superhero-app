package digital.wup.superheroapp.common.characters

import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.mvp.MvpPresenter
import digital.wup.superheroapp.common.mvp.MvpView

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