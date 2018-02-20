package digital.wup.android.data.model

import com.google.gson.annotations.SerializedName

data class CharacterDataWrapper(
        @SerializedName("code")
        var code: Int,
        @SerializedName("status")
        var status: String,
        @SerializedName("copyright")
        var copyright: String,
        @SerializedName("attributeText")
        var attributeText: String,
        @SerializedName("attributionHTML")
        var attributionHTML: String,
        @SerializedName("data")
        var data: CharacterDataContainer,
        @SerializedName("etag")
        var etag: String
)
