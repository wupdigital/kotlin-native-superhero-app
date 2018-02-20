package digital.wup.android.presentation.ui.details


import digital.wup.superheroapp.common.UseCaseHandler
import digital.wup.superheroapp.common.charaterdetail.CharacterDetailMvpPresenter
import digital.wup.superheroapp.common.charaterdetail.CharacterDetailMvpView
import digital.wup.superheroapp.common.charaterdetail.domain.usecase.GetCharacterRequest
import digital.wup.superheroapp.common.charaterdetail.domain.usecase.GetCharacterResponse
import digital.wup.superheroapp.common.charaterdetail.domain.usecase.GetCharacterUseCase

class DetailsPresenterImpl(private val useCase: GetCharacterUseCase, private val handler: UseCaseHandler) : CharacterDetailMvpPresenter{
    private var view: CharacterDetailMvpView? = null

    override fun takeView(view: CharacterDetailMvpView) {
        this.view = view
    }

    override fun dropView() {
        this.view = null
    }

    override fun loadCharacter(characterId: Int) {
        val request = GetCharacterRequest(characterId)

        handler.executeUseCase(useCase, request, {

            it.character?.let {
                view?.showCharacter(it)
            } ?: run {
                view?.showNoCharacter()
            }

        }, {
            view?.showErrorMessage("Something wrong!")
        })
    }
}
