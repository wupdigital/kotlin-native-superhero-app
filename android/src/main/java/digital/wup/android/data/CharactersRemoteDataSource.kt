package digital.wup.android.data

import digital.wup.android.data.model.CharacterDataWrapper
import digital.wup.android.data.model.CharacterNet
import digital.wup.android.data.model.toCharacter
import digital.wup.android.data.network.CharacterService
import digital.wup.superheroapp.common.characters.domain.model.Page
import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.datasource.CharactersDataSource
import okhttp3.OkHttpClient
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class CharactersRemoteDataSource(okHttpClient: OkHttpClient) : CharactersDataSource {
    override fun loadCharacters(page: Page, complete: (List<Character>) -> Unit, fail: () -> Unit) {
        service.loadCharacters(page.limit, page.offset).enqueue(object : Callback<CharacterDataWrapper> {
            override fun onResponse(call: Call<CharacterDataWrapper>, response: Response<CharacterDataWrapper>) {
                if (response.body() != null) {
                    val results: Array<CharacterNet> = response.body()!!.data.results
                    val resultsList: MutableList<Character> = mutableListOf()
                    results.mapTo(resultsList, { it.toCharacter() })
                    complete(resultsList)
                } else
                    fail()
            }

            override fun onFailure(call: Call<CharacterDataWrapper>, t: Throwable) {
                fail()
            }
        })
    }

    override fun loadCharacter(characterId: Int, complete: (Character?) -> Unit, fail: () -> Unit) {
        service.loadCharacter(characterId.toString()).enqueue(object : Callback<CharacterDataWrapper> {
            override fun onResponse(call: Call<CharacterDataWrapper>, response: Response<CharacterDataWrapper>) {
                if (response.body() != null)
                    complete(response.body()!!.data.results.first().toCharacter())
                else
                    fail()
            }

            override fun onFailure(call: Call<CharacterDataWrapper>, t: Throwable) {
                fail()
            }
        })
    }

    override fun saveCharacters(characters: List<Character>, complete: () -> Unit, fail: () -> Unit) {
        complete()
    }

    private val service: CharacterService

    init {
        val retrofit = Retrofit.Builder()
                .baseUrl("https://gateway.marvel.com/")
                .addConverterFactory(GsonConverterFactory.create())
                .client(okHttpClient)
                .build()

        service = retrofit.create(CharacterService::class.java)
    }
}
