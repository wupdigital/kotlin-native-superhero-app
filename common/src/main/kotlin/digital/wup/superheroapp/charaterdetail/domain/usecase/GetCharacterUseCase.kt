package digital.wup.superheroapp.charaterdetail.domain.usecase

import digital.wup.superheroapp.UseCase
import digital.wup.superheroapp.UseCaseRequest
import digital.wup.superheroapp.UseCaseResponse
import digital.wup.superheroapp.characters.domain.model.Character
import digital.wup.superheroapp.datasource.CharactersDataSource

class GetCharacterRequest(val characterId: Int) : UseCaseRequest

class GetCharacterResponse(val character: Character?): UseCaseResponse

class GetCharacterUseCase(private val charactersDataSource: CharactersDataSource): UseCase<GetCharacterRequest, GetCharacterResponse>() {

    override fun executeUseCase(request: GetCharacterRequest) {
        charactersDataSource.loadCharacter(request.characterId, {
            val response = GetCharacterResponse(it)
            success(response)
        }, {
            error()
        })
    }
}