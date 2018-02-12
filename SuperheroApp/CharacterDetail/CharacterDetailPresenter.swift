//
//  CharacterDetailPresenter.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

class CharacterDetailPresenter: CharacterDetailContract.CharacterDetailPresenter {
    
    private let useCaseHandler: UseCaseHandler
    private let getCharacterUseCase: GetCharacterUseCase
    private weak var view: CharacterDetailPresenter.ViewType?
    
    init(useCaseHandler: UseCaseHandler, getCharacterUseCase: GetCharacterUseCase) {
        self.useCaseHandler = useCaseHandler
        self.getCharacterUseCase = getCharacterUseCase
    }

    func takeView(view: CharacterDetailPresenter.ViewType) {
        self.view = view
    }
    
    func loadCharacter(characterId: String) {
        let request = GetCharacterUseCase(characterId)
        
        self.useCaseHandler.executeUseCase(useCase: self.getCharacterUseCase, request: request, success: { (response: GetCharacterResponse) in
            self.view.showCharacter(character)
        }, error: {
            
        })
    }
}
