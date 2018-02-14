//
//  CharacterDetailContract.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

protocol CharacterDetailMvpView: MvpView {
    
    func showCharacter(character: Character)
}

protocol CharacterDetailMvpPresenter: MvpPresenter {
    
    func takeView(view: CharacterDetailMvpView)
    
    func loadCharacter(characterId: Int)
}
