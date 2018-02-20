package digital.wup.superhero.presentation.ui.details


import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.mvp.MvpPresenter
import digital.wup.superheroapp.common.mvp.MvpView

interface DetailsContract {
    interface DetailsPresenter : MvpPresenter {
        fun takeView(view: DetailsContract.DetailsView)

        fun loadCharacter(id: String)
    }

    interface DetailsView : MvpView {
        fun showLoadingIndicator()

        fun hideLoadingIndicator()

        fun showCharacter(characters: Character)

        fun showLoadingCharacterError()

        fun showNoCharacter()
    }
}
