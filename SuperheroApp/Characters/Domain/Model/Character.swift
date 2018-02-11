//
//  Character.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Foundation

@objc class Character: NSObject {
    var characterId: Int
    var name: String
    var thumbnailUrl: String
    
    override init() {
        self.characterId = 0
        self.name = ""
        self.thumbnailUrl = ""
    }
    
    init(characterId: Int, name: String, thumbnailUrl: String) {
        self.characterId = characterId
        self.name = name
        self.thumbnailUrl = thumbnailUrl
    }
    
}
