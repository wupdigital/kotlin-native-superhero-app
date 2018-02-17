//
//  CharactersPresenter.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 12..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Common

private let defaultLimit = Int32(100)

class CharactersPreseneter: NSObject, CommonCharactersMvpPresenter {

    private let useCaseHandler: CommonUseCaseHandler
    private var getCharactersUseCase: CommonGetCharactersUseCase
    private weak var view: CommonCharactersMvpView?
    private var currentPage: CommonPage = CommonPage(limit: defaultLimit, offset: 0)
    private var objects: [CommonCharacter] = [CommonCharacter]()

    init(useCaseHandler: CommonUseCaseHandler, getCharactersUseCase: CommonGetCharactersUseCase) {
        self.useCaseHandler = useCaseHandler
        self.getCharactersUseCase = getCharactersUseCase
    }

    func takeView(view: CommonCharactersMvpView) {
        self.view = view
        self.loadCharacters()
    }

    func characters() -> [CommonCharacter] {
        return self.objects
    }

    func charactersCount() -> Int32 {
        return Int32(self.objects.count)
    }

    func loadCharacters() {

        self.view?.showLoadingIndicator()

        let request = CommonGetCharactersRequest(page: self.currentPage)

        self.useCaseHandler.executeUseCase(useCase: self.getCharactersUseCase,
                                           request: request,
                                           success: { (response: CommonUseCaseResponse) in

            self.view?.hideLoadingIndicator()

            if let response = response as? CommonGetCharactersResponse {
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
        let request = CommonGetCharactersRequest(page: self.currentPage)

        self.useCaseHandler.executeUseCase(useCase: self.getCharactersUseCase,
                                           request: request,
                                           success: { (response: CommonUseCaseResponse) in
            self.view?.hideMoreLoadingIndicator()

            if let response = response as? CommonGetCharactersResponse {
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
