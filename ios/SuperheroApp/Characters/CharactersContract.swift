//
//  CharactersContract.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

protocol CharactersMvpPresenter: MvpPresenter {

    func takeView(view: CharactersMvpView)

    func characters() -> [Character]

    func charactersCount() -> Int

    func loadCharacters()

    func loadMoreCharacters()
}

protocol CharactersMvpView: MvpView {

    func showLoadingIndicator()

    func hideLoadingIndicator()

    func showMoreLoadingIndicator()

    func hideMoreLoadingIndicator()

    func refreshCharacters()

    func showLoadingCharactersError(message: String)

    func showNoCharacters()
}
