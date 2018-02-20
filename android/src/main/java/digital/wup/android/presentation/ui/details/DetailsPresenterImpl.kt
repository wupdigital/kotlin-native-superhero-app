package digital.wup.android.presentation.ui.details


import digital.wup.superhero.presentation.ui.details.DetailsContract
import digital.wup.superheroapp.common.UseCaseHandler
import digital.wup.superheroapp.common.charaterdetail.domain.usecase.GetCharacterRequest
import digital.wup.superheroapp.common.charaterdetail.domain.usecase.GetCharacterResponse
import digital.wup.superheroapp.common.charaterdetail.domain.usecase.GetCharacterUseCase

class DetailsPresenterImpl(private val useCase: GetCharacterUseCase, private val handler: UseCaseHandler) : DetailsContract.DetailsPresenter {
    private var view: DetailsContract.DetailsView? = null

    override fun takeView(view: DetailsContract.DetailsView) {
        this.view = view
    }

    override fun loadCharacter(id: String) {
        val request = GetCharacterRequest(id.toInt())

        handler.executeUseCase(useCase, request, {
            onSuccess(it)
        }, {
            onError()
        })
    }

    private fun onSuccess(response: GetCharacterResponse) {
        view!!.showCharacter(response.character!!)
    }

    private fun onError() {
        view!!.showLoadingCharacterError()
    }
}
