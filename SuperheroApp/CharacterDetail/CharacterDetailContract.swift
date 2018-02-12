//
//  CharacterDetailContract.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

struct CharacterDetailContract {
    
    protocol CharacterDetailPresenter: MvpPresenter {
        typealias ViewType = CharacterDetailView
        
        func loadCharacter(characterId: String)
    }
    
    protocol CharacterDetailView: MvpView {
    
        func showCharacter(character: Character)
    }
}
