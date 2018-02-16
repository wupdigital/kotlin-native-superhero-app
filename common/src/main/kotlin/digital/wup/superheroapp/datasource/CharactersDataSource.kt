package digital.wup.superheroapp.datasource

import digital.wup.superheroapp.characters.usecase.model.Page
import digital.wup.superheroapp.characters.usecase.model.Character

interface CharactersDataSource {
    fun loadCharacters(page: Page, complete: (List<Character>) -> Unit, fail: () -> Unit)

    fun loadCharacter(characterId: Int, complete: (Character?) -> Unit, fail:() -> Unit)

    fun saveCharacters(characters: List<Character>, complete: () -> Unit, fail: () -> Unit)
}