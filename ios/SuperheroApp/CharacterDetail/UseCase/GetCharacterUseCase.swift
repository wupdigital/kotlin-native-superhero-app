//
//  GetCharacterUseCase.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Common

struct GetCharacterRequest: UseCaseRequest {
    let characterId: Int32

    init(characterId: Int32) {
        self.characterId = characterId
    }
}

struct GetCharacterResponse: UseCaseResponse {
    let character: CommonCharacter?

    init(character: CommonCharacter?) {
        self.character = character
    }
}

class GetCharacterUseCase: UseCase<GetCharacterRequest, GetCharacterResponse> {

    private var charactersDataSource: CharactersDataSource

    init(charactersDataSource: CharactersDataSource) {
        self.charactersDataSource = charactersDataSource
    }

    override func executeUseCase(request: GetCharacterRequest) throws {
        self.charactersDataSource.loadCharacter(characterId: request.characterId, complete: { (character) in

            if let success = self.success {
                let response = GetCharacterResponse(character: character)
                success(response)
            }
        }, fail: {
            if let error = self.error {
                error()
            }
        })
    }
}
