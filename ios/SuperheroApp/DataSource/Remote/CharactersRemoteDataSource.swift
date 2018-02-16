//
//  CharactersRemoteDataSource.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Alamofire
import AlamofireActivityLogger
import CodableAlamofire
import Common

class CharactersRemoteDataSource: NSObject, CommonCharactersDataSource {

    private let manager: SessionManager
    private let publicApiKey: String
    private let privateApiKey: String

    init(manager: SessionManager, publicApiKey: String, privateApiKey: String) {
        self.manager = manager
        self.publicApiKey = publicApiKey
        self.privateApiKey = privateApiKey
    }

    func loadCharacters(page: CommonPage,
                        complete: @escaping ([CommonCharacter]) -> CommonStdlibUnit,
                        fail: @escaping () -> CommonStdlibUnit) {
        let timestamp = Int(Date().timeIntervalSince1970)
        let hash = "\(timestamp)\(privateApiKey)\(publicApiKey)"

        let parameters = [ "limit": page.limit,
                           "offset": page.offset,
                           "apikey": self.publicApiKey,
                           "ts": timestamp,
                           "hash": hash.md5() ] as [String: Any]

        self.manager.request("https://gateway.marvel.com/v1/public/characters",
                             parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .log()
            .responseDecodableObject(keyPath: "data.results", decoder: JSONDecoder(),
                                     completionHandler: { (response: DataResponse<[CharacterResponse]>) in

                                        if response.error != nil {
                                            _ = fail()
                                        } else {
                                            _ = complete(response.value!.map({ $0.toCharacter() }))
                                        }
            })
    }

    func loadCharacter(characterId: Int32,
                       complete: @escaping (CommonCharacter?) -> CommonStdlibUnit,
                       fail: @escaping () -> CommonStdlibUnit) {

        let timestamp = Int(Date().timeIntervalSince1970)
        let hash = "\(timestamp)\(privateApiKey)\(publicApiKey)"

        let parameters = [ "apikey": self.publicApiKey,
                           "ts": timestamp,
                           "hash": hash.md5() ] as [String: Any]

        self.manager.request("https://gateway.marvel.com/v1/public/characters/\(characterId)",
            parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .log()
            .responseDecodableObject(keyPath: "data.results", decoder: JSONDecoder(),
                                     completionHandler: { (response: DataResponse<[CharacterResponse]>) in
                                        if response.error != nil {
                                            _ = fail()
                                        } else {
                                            _ = complete(response.value?.first?.toCharacter())
                                        }
            })
    }

    func saveCharacters(characters: [CommonCharacter],
                        complete: @escaping () -> CommonStdlibUnit,
                        fail: @escaping () -> CommonStdlibUnit) {
        _ = complete()
    }
}
