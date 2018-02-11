//
//  CharactersDataSource.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

protocol CharactersDataSource {
    
    func loadCharacters(page: Page, complete: @escaping ([Character]) -> Void, fail: @escaping () -> Void)
    
    func loadCharacter(characterId: String, complete: @escaping (Character?) -> Void, fail: @escaping () -> Void)

    func saveCharacters(characters: Array<Character>, complete: @escaping () -> Void, fail: @escaping () -> Void)
}
