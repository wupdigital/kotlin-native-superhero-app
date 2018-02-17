package digital.wup.superheroapp.datasource

import digital.wup.superheroapp.characters.usecase.model.Character
import digital.wup.superheroapp.characters.usecase.model.Page

class CharactersRepository(

        private val localDataSource: CharactersDataSource,
        private val remoteDataSource: CharactersDataSource

) : CharactersDataSource {

    override fun loadCharacters(page: Page, complete: (List<Character>) -> Unit, fail: () -> Unit) {
        localDataSource.loadCharacters(page, { characters ->
            if (characters.isEmpty()) {
                remoteDataSource.loadCharacters(page, { chars ->
                        localDataSource.saveCharacters(chars, {}, {})
                    complete(chars)
                }, fail)
            } else {
                complete(characters)
            }
        }, {
            remoteDataSource.loadCharacters(page, { characters ->
                    localDataSource.saveCharacters(characters, {}, {})
                complete(characters)
            }, fail)
        })
    }

    override fun loadCharacter(characterId: Int, complete: (Character?) -> Unit, fail: () -> Unit) {

        localDataSource.loadCharacter(characterId, { character ->
                if (character != null) {
                    complete(character)
                } else {
                    remoteDataSource.loadCharacter(characterId, complete, fail)
                }
        }, {
            remoteDataSource.loadCharacter(characterId, complete, fail)
        })
    }

    override fun saveCharacters(characters: List<Character>, complete: () -> Unit, fail: () -> Unit) {
        localDataSource.saveCharacters(characters, {
            remoteDataSource.saveCharacters(characters, complete, fail)
        }, {
            remoteDataSource.saveCharacters(characters, complete, fail)
        })
    }
}