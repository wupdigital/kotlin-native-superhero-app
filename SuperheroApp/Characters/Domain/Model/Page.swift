//
//  Page.swift
//  SuperheroApp
//
//  Created by Balazs Varga on 2018. 02. 11..
//  Copyright © 2018. W.UP. All rights reserved.
//

import Foundation

struct Page {
    var limit: Int
    var offset: Int

    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
}
