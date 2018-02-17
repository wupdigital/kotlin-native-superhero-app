package digital.wup.superheroapp.characters

import digital.wup.superheroapp.UseCaseHandler
import digital.wup.superheroapp.characters.domain.usecase.GetCharactersRequest
import digital.wup.superheroapp.characters.domain.usecase.GetCharactersResponse
import digital.wup.superheroapp.characters.domain.usecase.GetCharactersUseCase
import digital.wup.superheroapp.characters.domain.model.Character
import digital.wup.superheroapp.characters.domain.model.Page

const val DEFAULT_LIMIT = 100

class CharactersPresenter(
        private val useCaseHandler: UseCaseHandler,
        private val getCharactersUseCase: GetCharactersUseCase
) : CharactersMvpPresenter {

    private var view: CharactersMvpView? = null
    private var currentPage: Page = Page(DEFAULT_LIMIT,  0)
    private var objects: MutableList<Character> = mutableListOf()


    override fun takeView(view: CharactersMvpView) {
        this.view = view
        this.loadCharacters()
    }

    override fun dropView() {
        view = null
    }

    override fun characters() : List<Character> {
        return objects
    }

    override fun charactersCount() : Int {
        return objects.count()
    }

    override fun loadCharacters() {
        view?.showLoadingIndicator()

        val request = GetCharactersRequest(currentPage)

        useCaseHandler.executeUseCase(getCharactersUseCase, request, { response: GetCharactersResponse ->
            view?.hideLoadingIndicator()

            if (response.characters.isEmpty()) {
                view?.showNoCharacters()
            } else {
                objects.addAll(response.characters)
                view?.refreshCharacters()
            }

        }, {
            view?.hideLoadingIndicator()
            // TODO hardcoded message
            view?.showLoadingCharactersError("Something wrong!")
        })
    }

    override fun loadMoreCharacters() {
        view?.showMoreLoadingIndicator()

        currentPage.offset += DEFAULT_LIMIT
        val request = GetCharactersRequest(currentPage)

        useCaseHandler.executeUseCase(getCharactersUseCase, request, { response: GetCharactersResponse ->
            view?.hideMoreLoadingIndicator()

                if (response.characters.isEmpty()) {
                    view?.showNoCharacters()
                } else {
                    objects.addAll(response.characters)
                    view?.refreshCharacters()
                }
        }, {
            // TODO remove hardcoded message
            view?.hideMoreLoadingIndicator()
            view?.showLoadingCharactersError("Something wrong!")
        })
    }
}