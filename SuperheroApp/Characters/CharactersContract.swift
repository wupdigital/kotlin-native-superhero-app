//
//  CharactersContract.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

struct CharactersContract {
    
    protocol CharactersPresenter: MvpPresenter {
        
        typealias ViewType = CharactersView
        
        func characters() -> [Character]
        
        func charactersCount() -> Int
        
        func loadCharacters()
        
        func loadMoreCharacters()
    }
    
    protocol CharactersView: MvpView {
        
        func showLoadingIndicator()
        
        func hideLoadingIndicator()
    
        func showMoreLoadingIndicator()
        
        func hideMoreLoadingIndicator()
        
        func refreshCharacters()
        
        func showLoadingCharactersError(message: String)
        
        func showNoCharacters()
    }
}
