//
//  Character.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Foundation

@objc class Character: NSObject {
    @objc var characterId: Int
    @objc var name: String
    @objc var thumbnailUrl: String
    
    override init() {
        self.characterId = 0
        self.name = ""
        self.thumbnailUrl = ""
    }
    
    @objc init(characterId: Int, name: String, thumbnailUrl: String) {
        self.characterId = characterId
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
}
