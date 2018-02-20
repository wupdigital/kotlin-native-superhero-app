package digital.wup.android.data.local

import io.objectbox.annotation.Entity
import io.objectbox.annotation.Id


@Entity
data class CharacterDto(
        @Id
        var id: Long,
        var characterId: String,
        var name: String,
        var description: String,
        var path: String,
        var extension: String
)