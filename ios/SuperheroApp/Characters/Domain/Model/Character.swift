//
//  Character.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Foundation

struct Character {
    var characterId: Int
    var name: String
    var thumbnailUrl: String

    private enum CodingKeys: String, CodingKey {
        case characterId = "id"
        case name
        case thumbnail
    }

    private enum ThumbnailKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}

extension Character: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.characterId = try values.decode(Int.self, forKey: .characterId)
        self.name = try values.decode(String.self, forKey: .name)

        let thumbnail = try values.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
        let path = try thumbnail.decode(String.self, forKey: .path).replacingOccurrences(of: "http", with: "https")
        let ext = try thumbnail.decode(String.self, forKey: .ext)
        self.thumbnailUrl = "\(path).\(ext)"
    }
}
