//
//  GetCharacterUseCase.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

struct GetCharacterRequest: UseCaseRequest {
    var characterId: String
    
    init(characterId: String) {
        self.characterId = characterId
    }
}

struct GetCharacterResponse: UseCaseResponse {
    var character: Character?
    
    init(character: Character?) {
        self.character = character
    }
}

class GetCharacterUseCase: UseCase<GetCharacterRequest, GetCharacterResponse> {
    
    private var charactersDataSource: CharactersDataSource
    
    init(charactersDataSource: CharactersDataSource) {
        self.charactersDataSource = charactersDataSource
    }
    
    override func execute(request: GetCharacterRequest) throws {
        self.charactersDataSource.loadCharacter(characterId: request.characterId, complete: { (character) in
            let response = GetCharactersResponse()
            response.character = character
            self.success(response)
            
        }, fail: {
            self.error()
        })
    }
}
