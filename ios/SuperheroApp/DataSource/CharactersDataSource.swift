//
//  CharactersDataSource.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Common

protocol CharactersDataSource {

    func loadCharacters(page: CommonPage, complete: @escaping ([CommonCharacter]) -> Void, fail: @escaping () -> Void)

    func loadCharacter(characterId: Int32, complete: @escaping (CommonCharacter?) -> Void, fail: @escaping () -> Void)

    func saveCharacters(characters: [CommonCharacter], complete: @escaping () -> Void, fail: @escaping () -> Void)
}
