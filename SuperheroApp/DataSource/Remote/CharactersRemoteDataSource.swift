//
//  CharactersRemoteDataSource.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Alamofire
import CodableAlamofire

class CharactersRemoteDataSource : CharactersDataSource {

    private let manager: SessionManager
    private let publicApiKey: String
    private let privateApiKey: String
    
    init(manager: SessionManager, publicApiKey: String, privateApiKey: String) {
        self.manager = manager
        self.publicApiKey = publicApiKey
        self.privateApiKey = privateApiKey
    }
    
    func loadCharacters(page: Page, complete: @escaping ([Character]) -> Void, fail: @escaping () -> Void) {
        
        let timestamp = Date().timeIntervalSince1970
        let hash = "\(timestamp)\(publicApiKey)\(privateApiKey)"
        
        let parameters = [ "limit": page.limit,
                           "offset": page.offset,
                           "apikey": self.publicApiKey,
                           "ts": timestamp,
                           "hash": hash.md5() ] as [String : Any]
        
    
        self.manager.request("v1/public/characters", parameters: parameters, encoding: URLEncoding.default)
            .responseDecodableObject(keyPath: "data.results", decoder: JSONDecoder(), completionHandler: { (response: DataResponse<[Character]>) in
                if (response.error != nil) {
                    fail()
                } else {
                    complete(response.value!)
                }
            })
    }
    
    func loadCharacter(characterId: String, complete: @escaping (Character?) -> Void, fail: @escaping () -> Void) {
        let timestamp = Date().timeIntervalSince1970
        let hash = "\(timestamp)\(publicApiKey)\(privateApiKey)"
        
        let parameters = [ "apikey": self.publicApiKey,
                           "ts": timestamp,
                           "hash": hash.md5() ] as [String : Any]
        
        
        self.manager.request("v1/public/characters/\(characterId)", parameters: parameters, encoding: URLEncoding.default)
            .responseDecodableObject(keyPath: "data.results", decoder: JSONDecoder(), completionHandler: { (response: DataResponse<[Character]>) in
                if (response.error != nil) {
                    fail()
                } else {
                    complete(response.value?.first)
                }
            })
    }
    
    func saveCharacters(characters: Array<Character>, complete: @escaping () -> Void, fail: @escaping () -> Void) {
        complete()
    }
}
