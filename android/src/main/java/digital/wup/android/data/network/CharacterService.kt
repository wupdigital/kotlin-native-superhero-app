package digital.wup.android.data.network


import digital.wup.android.data.model.CharacterDataWrapper
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

interface CharacterService {
    @GET("/v1/public/characters")
    fun loadCharacters(@Query("limit") limit: Int, @Query("offset") offset: Int): Call<CharacterDataWrapper>

    @GET("/v1/public/characters/{characterId}")
    fun loadCharacter(@Path("characterId") id: String): Call<CharacterDataWrapper>
}