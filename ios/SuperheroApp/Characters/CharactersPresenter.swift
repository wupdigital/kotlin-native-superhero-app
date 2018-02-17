//
//  CharactersPresenter.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Common

private let defaultLimit = Int32(100)

class CharactersPreseneter: CharactersMvpPresenter {

    private let useCaseHandler: CommonUseCaseHandler
    private var getCharactersUseCase: GetCharactersUseCase
    private weak var view: CharactersMvpView?
    private var currentPage: CommonPage = CommonPage(limit: defaultLimit, offset: 0)
    private var objects: [CommonCharacter] = [CommonCharacter]()

    init(useCaseHandler: CommonUseCaseHandler, getCharactersUseCase: GetCharactersUseCase) {
        self.useCaseHandler = useCaseHandler
        self.getCharactersUseCase = getCharactersUseCase
    }

    func takeView(view: CharactersMvpView) {
        self.view = view
        self.loadCharacters()
    }

    func characters() -> [CommonCharacter] {
        return self.objects
    }

    func charactersCount() -> Int {
        return self.objects.count
    }

    func loadCharacters() {

        self.view?.showLoadingIndicator()

        let request = GetCharactersRequest(page: self.currentPage)

        self.useCaseHandler.executeUseCase(useCase: self.getCharactersUseCase,
                                           request: request,
                                           success: { (response: CommonUseCaseResponse) in

            self.view?.hideLoadingIndicator()

            if let response = response as? GetCharactersResponse {
                if response.characters.isEmpty {
                    self.view?.showNoCharacters()
                } else {
                    self.objects.append(contentsOf: response.characters)
                    self.view?.refreshCharacters()
                }
            }
            return CommonStdlibUnit()
        }, error: {
            self.view?.hideLoadingIndicator()
            // TODO hardcoded message
            self.view?.showLoadingCharactersError(message: "Something wrong!")
            return CommonStdlibUnit()
        })
    }

    func loadMoreCharacters() {
        self.view?.showMoreLoadingIndicator()

        self.currentPage.offset += defaultLimit
        let request = GetCharactersRequest(page: self.currentPage)

        self.useCaseHandler.executeUseCase(useCase: self.getCharactersUseCase,
                                           request: request,
                                           success: { (response: CommonUseCaseResponse) in
            self.view?.hideMoreLoadingIndicator()

            if let response = response as? GetCharactersResponse {
                if response.characters.isEmpty {
                    self.view?.showNoCharacters()
                } else {
                    self.objects.append(contentsOf: response.characters)
                    self.view?.refreshCharacters()
                }
            }
            return CommonStdlibUnit()
        }, error: {
            // TODO remove hardcoded message
            self.view?.hideMoreLoadingIndicator()
            self.view?.showLoadingCharactersError(message: "Something wrong!")
            return CommonStdlibUnit()
        })
    }
}
