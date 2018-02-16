//
//  CharactersUseCase.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Common

struct GetCharactersRequest: UseCaseRequest {
    var page: CommonPage
}

struct GetCharactersResponse: UseCaseResponse {
    var characters: [CommonCharacter]
}

class GetCharactersUseCase: UseCase<GetCharactersRequest, GetCharactersResponse> {

    private let charactersDataSource: CommonCharactersDataSource

    init(charactersDataSource: CommonCharactersDataSource) {
        self.charactersDataSource = charactersDataSource
    }

    override func executeUseCase(request: GetCharactersRequest) throws {
        self.charactersDataSource.loadCharacters(page: request.page, complete: { (characters: [CommonCharacter]) in
            let response = GetCharactersResponse(characters: characters)
            if let success = self.success {
                _ = success(response)
            }

            return CommonStdlibUnit()
        }, fail: {
            if let error = self.error {
                _ = error()
            }

            return CommonStdlibUnit()
        })
    }
}
