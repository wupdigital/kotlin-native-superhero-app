package digital.wup.android.data.model


import com.google.gson.annotations.SerializedName

data class Image(
        @SerializedName("path")
        var path: String,
        @SerializedName("extension")
        var extension: String
)
