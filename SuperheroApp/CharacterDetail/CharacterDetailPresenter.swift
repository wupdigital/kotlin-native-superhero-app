//
//  CharacterDetailPresenter.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

class CharacterDetailPresenter: CharacterDetailMvpPresenter {
    
    private let useCaseHandler: UseCaseHandler
    private let getCharacterUseCase: GetCharacterUseCase
    private var view: CharacterDetailMvpView?
    
    init(useCaseHandler: UseCaseHandler, getCharacterUseCase: GetCharacterUseCase) {
        self.useCaseHandler = useCaseHandler
        self.getCharacterUseCase = getCharacterUseCase
    }

    func takeView(view: CharacterDetailMvpView) {
        self.view = view
    }
    
    func loadCharacter(characterId: String) {
        let request = GetCharacterRequest(characterId: characterId)
        
        self.useCaseHandler.executeUseCase(useCase: self.getCharacterUseCase, request: request, success: { (response: GetCharacterResponse) in
            
            if let character = response.character {
                
                self.view?.showCharacter(character: character)
                
            } else {
                // TODO character not found
            }
        }, error: {
            // TODO show error message
        })
    }
}
