package digital.wup.superheroapp.common.charaterdetail.domain.usecase

import digital.wup.superheroapp.common.UseCase
import digital.wup.superheroapp.common.UseCaseRequest
import digital.wup.superheroapp.common.UseCaseResponse
import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.datasource.CharactersDataSource

class GetCharacterRequest(val characterId: Int) : UseCaseRequest

class GetCharacterResponse(val character: Character?) : UseCaseResponse

class GetCharacterUseCase(private val charactersDataSource: CharactersDataSource) : UseCase<GetCharacterRequest, GetCharacterResponse>() {

    override fun executeUseCase(request: GetCharacterRequest) {
        charactersDataSource.loadCharacter(request.characterId, {
            val response = GetCharacterResponse(it)
            success(response)
        }, {
            error()
        })
    }
}