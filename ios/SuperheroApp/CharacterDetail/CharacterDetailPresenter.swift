//
//  CharacterDetailPresenter.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Common

class CharacterDetailPresenter: CharacterDetailMvpPresenter {

    private let useCaseHandler: CommonUseCaseHandler
    private let getCharacterUseCase: CommonGetCharacterUseCase
    private weak var view: CharacterDetailMvpView?

    init(useCaseHandler: CommonUseCaseHandler, getCharacterUseCase: CommonGetCharacterUseCase) {
        self.useCaseHandler = useCaseHandler
        self.getCharacterUseCase = getCharacterUseCase
    }

    func takeView(view: CommonMvpView) {
        if let view = view as? CharacterDetailMvpView {
            self.view = view
        }
    }

    func dropView() {
        self.view = nil
    }

    func loadCharacter(characterId: Int32) {
        let request = CommonGetCharacterRequest(characterId: characterId)

        self.useCaseHandler.executeUseCase(useCase: self.getCharacterUseCase,
                                           request: request,
                                           success: { (response: CommonUseCaseResponse) in

            if let response = response as? CommonGetCharacterResponse {
                if let character = response.character {

                    self.view?.showCharacter(character: character)

                } else {
                    // TODO character not found
                }
            }
            return CommonStdlibUnit()
        }, error: {
            // TODO show error message
            return CommonStdlibUnit()
        })
    }
}
