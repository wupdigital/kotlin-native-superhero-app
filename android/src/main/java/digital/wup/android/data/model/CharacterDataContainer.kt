package digital.wup.android.data.model


import com.google.gson.annotations.SerializedName
import java.util.*

data class CharacterDataContainer(
        @SerializedName("offset")
        var offset: Int,
        @SerializedName("limit")
        var limit: Int,
        @SerializedName("total")
        var total: Int,
        @SerializedName("count")
        var count: Int,
        @SerializedName("results")
        var results: Array<CharacterNet>
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as CharacterDataContainer

        if (offset != other.offset) return false
        if (limit != other.limit) return false
        if (total != other.total) return false
        if (count != other.count) return false
        if (!Arrays.equals(results, other.results)) return false

        return true
    }

    override fun hashCode(): Int {
        var result = offset
        result = 31 * result + limit
        result = 31 * result + total
        result = 31 * result + count
        result = 31 * result + Arrays.hashCode(results)
        return result
    }
}
