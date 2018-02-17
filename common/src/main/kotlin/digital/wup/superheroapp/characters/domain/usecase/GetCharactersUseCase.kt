package digital.wup.superheroapp.characters.domain.usecase

import digital.wup.superheroapp.UseCase
import digital.wup.superheroapp.UseCaseRequest
import digital.wup.superheroapp.UseCaseResponse
import digital.wup.superheroapp.characters.domain.usecase.model.Character
import digital.wup.superheroapp.characters.domain.usecase.model.Page
import digital.wup.superheroapp.datasource.CharactersDataSource

class GetCharactersRequest(val page: Page) : UseCaseRequest

class GetCharactersResponse(val characters: List<Character>): UseCaseResponse

class GetCharactersUseCase(private val charactersDataSource: CharactersDataSource): UseCase<GetCharactersRequest, GetCharactersResponse>() {

    override fun executeUseCase(request: GetCharactersRequest) {
        charactersDataSource.loadCharacters(request.page, { characters: List<Character> ->
            val response = GetCharactersResponse(characters)
            success(response)
        }, {
            error()
        })
    }
}