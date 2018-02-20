package digital.wup.android.data.model

import com.google.gson.annotations.SerializedName

data class CharacterNet(
        @SerializedName("id")
        var id: Long,
        @SerializedName("name")
        var name: String,
        @SerializedName("description")
        var description: String,
        @SerializedName("thumbnail")
        var thumbnail: Image?
)
