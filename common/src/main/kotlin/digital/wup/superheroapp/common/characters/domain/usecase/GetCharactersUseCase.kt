package digital.wup.superheroapp.common.characters.domain.usecase

import digital.wup.superheroapp.common.UseCase
import digital.wup.superheroapp.common.UseCaseRequest
import digital.wup.superheroapp.common.UseCaseResponse
import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.characters.domain.model.Page
import digital.wup.superheroapp.common.datasource.CharactersDataSource

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