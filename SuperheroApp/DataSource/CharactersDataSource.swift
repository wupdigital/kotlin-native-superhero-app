//
//  CharactersDataSource.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Foundation

protocol CharactersDataSource {
    
    func loadCharacters(page: Page, complete: ([Character]) -> Void, fail: () -> Void)
    
    func loadCharacter(characterId: String, complete: (Character) -> Void, fail: () -> Void)

    func saveCharacters(characters: Array<Character>, complete: () -> Void, fail: () -> Void)
}
