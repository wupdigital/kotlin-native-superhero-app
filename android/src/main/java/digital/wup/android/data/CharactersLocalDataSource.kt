package digital.wup.android.data

import android.app.Application
import digital.wup.android.SuperheroApp
import digital.wup.android.data.local.CharacterDto
import digital.wup.android.data.model.toCharacterDto
import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.characters.domain.model.Page
import digital.wup.superheroapp.common.datasource.CharactersDataSource
import io.objectbox.Box
import io.objectbox.query.QueryBuilder

class CharactersLocalDataSource(application: Application) : CharactersDataSource {
    private val dataBase: Box<CharacterDto> = (application as SuperheroApp).boxStore.boxFor<CharacterDto>()

    override fun loadCharacters(page: Page, complete: (List<Character>) -> Unit, fail: () -> Unit) {
        val queryBuilder: QueryBuilder<CharacterDto> = dataBase.query()
        val charactersDto = queryBuilder.build().find()
        var characters: MutableList<Character> = mutableListOf()
        charactersDto.mapTo(characters) { it.toCharacterDto() }
        if (characters.isNotEmpty()) {
            complete(characters)
        } else {
            fail()
        }
    }

    override fun loadCharacter(characterId: Int, complete: (Character?) -> Unit, fail: () -> Unit) {
        val queryBuilder: QueryBuilder<CharacterDto> = dataBase.query()
        val character = queryBuilder.equal(CharacterDto_.characterId, characterId).build().findFirst()
        if (character != null)
            complete(character)
        else
            fail()
    }

    override fun saveCharacters(characters: List<Character>, complete: () -> Unit, fail: () -> Unit) {
        try {
            val charactersDto: MutableList<CharacterDto> = mutableListOf()
            characters.mapTo(charactersDto) { it.toCharacterDto() }
            dataBase.put(charactersDto)
            complete()
        } catch (e: Exception) {
            fail()
        }
    }
}
