//
//  CharactersPresenter.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

fileprivate let defaultLimit = 100

class CharactersPreseneter: CharactersContract.CharactersPresenter {
    
    typealias ViewType = CharactersContract.CharactersView
    
    private let useCaseHandler: UseCaseHandler
    private var getCharactersUseCase: GetCharacterUseCase
    private weak var view: CharactersContract.CharactersView?
    private var currentPage: Page = Page(limit: defaultLimit, offset: 0)
    private var characters: Array<Characters> = Array()
    
    init(useCaseHandler: UseCaseHandler, getCharactersUseCase: GetCharactersUseCase) {
        self.useCaseHandler = useCaseHandler
        self.getCharactersUseCase = getCharactersUseCase
    }
    
    func takeView(view: CharactersContract.CharactersView) {
        self.view = view
        self.loadCharacters()
    }

    func characters() -> [Character] {
        return self.characters
    }
        
    func charactersCount() -> Int {
        return self.characters.count
    }
        
    func loadCharacters() {
        
        self.view?.showLoadingIndicator()
        
        let request = GetCharactersRequest(self.currentPage)
        
        self.useCaseHandler.executeUseCase(useCase: self.getCharactersUseCase, request: request, success: { (response: GetCharactersResponse) in
            self.view?.hideLoadingIndicator()

            if (response.characters.isEmpty) {
                self.view?.showNoCharacters()
            } else {
                self.characters = response.characters
                self.view?.refreshCharacters()
            }
        }, fail: {
            self.view?.hideLoadingIndicator()
            // TODO hardcoded message
            self.view?.showLoadingCharactersError(message: "Something wrong!")
        })
    }
        
    func loadMoreCharacters() {
        self.view?.showMoreLoadingIndicator()
        
        self.currentPage.offset += defaultLimit
        let request = GetCharactersRequest(self.currentPage)
        
        self.useCaseHandler.executeUseCase(useCase: self.getCharactersUseCase, request: request, success: { (response: GetCharactersResponse) in
            self.view?.hideMoreLoadingIndicator()
            
            if (response.characters.isEmpty) {
                self.view?.showNoCharacters()
            } else {
                // TODO append characters
                self.characters = response.characters
                self.view?.refreshCharacters()
            }
        }, fail: {
            // TODO hardcoded message
            self.view?.hideMoreLoadingIndicator()
            self.view?.showLoadingCharactersError(message: "Something wrong!")
        })
    }
}
