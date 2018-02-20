package digital.wup.android.data.model

import digital.wup.android.data.local.CharacterDto
import digital.wup.superheroapp.common.characters.domain.model.Character

fun CharacterNet.toCharacter(): Character {
    return Character(this.id.toInt(), this.name, "", this.thumbnail!!.path)
}

fun Character.toCharacterNet(): CharacterNet {
    return CharacterNet(this.characterId.toLong(), this.name, "", Image(this.thumbnailUrl, "jpg"))
}

fun Character.toCharacterDto(): CharacterDto {
    return CharacterDto(0, this.characterId.toString(), this.name, "", this.thumbnailUrl, "jpg")
}

fun CharacterDto.toCharacterDto(): Character {
    return Character(this.characterId.toInt(), this.name, "", this.path)
}