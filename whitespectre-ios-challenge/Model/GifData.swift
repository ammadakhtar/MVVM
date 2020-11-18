//
//  GyphData.swift
//  whitespectre-ios-challenge
//
//  Created by Mac on 5/30/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class GifData {
    
    var ghyphs = [Gif]()
    var pagination = 0
    
    init(gyphArray: [Gif], paginationCount: Int) {
        ghyphs = gyphArray
        pagination = paginationCount
    }
}
