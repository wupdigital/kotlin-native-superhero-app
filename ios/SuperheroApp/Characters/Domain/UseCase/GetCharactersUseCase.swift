//
//  CharactersUseCase.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Foundation
import Common

class GetCharactersRequest: CommonUseCaseRequest {
    var page: CommonPage

    init(page: CommonPage) {
        self.page = page
    }
}

class GetCharactersResponse: CommonUseCaseResponse {
    let characters: [CommonCharacter]

    init(characters: [CommonCharacter]) {
        self.characters = characters
    }
}

class GetCharactersUseCase: CommonUseCase {

    private let charactersDataSource: CommonCharactersDataSource

    init(charactersDataSource: CommonCharactersDataSource) {
        self.charactersDataSource = charactersDataSource
    }

    override func executeUseCase(request: CommonUseCaseRequest) {
        if let request = request as? GetCharactersRequest {

            self.charactersDataSource.loadCharacters(page: request.page, complete: { (characters: [CommonCharacter]) in
                let response = GetCharactersResponse(characters: characters)

                return self.success(response)
            }, fail: {
                return self.error()
            })
        }
    }
}
