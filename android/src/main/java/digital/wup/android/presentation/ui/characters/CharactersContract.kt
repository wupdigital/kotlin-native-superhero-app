package digital.wup.android.presentation.ui.characters


import android.os.Bundle

import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.mvp.MvpPresenter
import digital.wup.superheroapp.common.mvp.MvpView

interface CharactersContract {
    interface CharactersPresenter : MvpPresenter {
        fun takeView(view: CharactersView)

        fun characters(): Array<Character>

        fun charactersCount(): Int

        fun loadCharacters()

        fun loadMoreCharacters()
    }

    interface CharactersView : MvpView {
        fun showLoadingIndicator()

        fun hideLoadingIndicator()

        fun showMoreLoadingIndicator()

        fun hideMoreLoadingIndicator()

        fun showCharacters(characters: Array<Character>)

        fun showLoadingCharactersError()

        fun showNoCharacters()

        fun navigateToDetails(bundle: Bundle)
    }
}
