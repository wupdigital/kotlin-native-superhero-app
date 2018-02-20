package digital.wup.android.presentation.ui.characters


import digital.wup.superheroapp.common.UseCaseHandler
import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.characters.domain.model.Page
import digital.wup.superheroapp.common.characters.domain.usecase.GetCharactersRequest
import digital.wup.superheroapp.common.characters.domain.usecase.GetCharactersResponse
import digital.wup.superheroapp.common.characters.domain.usecase.GetCharactersUseCase


class CharacatersPresenterImpl(private val useCase: GetCharactersUseCase, private val handler: UseCaseHandler) : CharactersContract.CharactersPresenter {
    private var view: CharactersContract.CharactersView? = null

    override fun takeView(view: CharactersContract.CharactersView) {
        this.view = view
    }

    override fun characters(): Array<Character> {
        return arrayOf()
    }

    override fun charactersCount(): Int {
        return 0
    }

    override fun loadCharacters() {
        val request = GetCharactersRequest(Page(100, 10))

        handler.executeUseCase(useCase, request, {
            onSuccess(it)
        }, {
            onError()
        })
    }

    override fun loadMoreCharacters() {

    }

    private fun onSuccess(response: GetCharactersResponse) {
        if (response.characters.isNotEmpty())
            view!!.showCharacters(response.characters.toTypedArray())
    }

    private fun onError() {
        view!!.showNoCharacters()
    }
}
