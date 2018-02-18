//
//  CharacterDetailPresenter.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Common

class CharacterDetailPresenter: NSObject, CommonCharacterDetailMvpPresenter {

    private let useCaseHandler: CommonUseCaseHandler
    private let getCharacterUseCase: CommonGetCharacterUseCase
    private weak var view: CommonCharacterDetailMvpView?

    init(useCaseHandler: CommonUseCaseHandler, getCharacterUseCase: CommonGetCharacterUseCase) {
        self.useCaseHandler = useCaseHandler
        self.getCharacterUseCase = getCharacterUseCase
    }

    func takeView(view_ view: CommonCharacterDetailMvpView) {
        self.view = view
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
                    self.view?.showNoCharacter()
                }
            }
            return CommonStdlibUnit()
        }, error: {
            self.view?.showErrorMessage(message: "Something wrong")
            return CommonStdlibUnit()
        })
    }
}
