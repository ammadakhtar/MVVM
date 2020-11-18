//
//  Gyph.swift
//  whitespectre-ios-challenge
//
//  Created by Mac on 5/29/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class Gif: Equatable {
    
    var id = ""
    var title = ""
    var gifUrl = ""
    
    /*
     - This init method is to populate our Glyph model from json.
     */
    
    init(gyphDict: Dictionary<String, AnyObject>) {
        
        if let id = gyphDict["id"] as? String {
            self.id = id
        }
        
        if let title = gyphDict["title"] as? String {
            self.title = title
        }
        
        if let images = gyphDict["images"] as? Dictionary<String,AnyObject> {
            
            if let downsizedGyph = images["fixed_height_downsampled"] as? Dictionary<String, AnyObject> {
                
                if let url = downsizedGyph["url"] as? String {
                    gifUrl = url
                }
            }
        }
    }
    
    /*
     - This init method is to validate unit test for our Gif Property
     */
    
    init(title: String, id: String, url: String) {
        self.title = title
        self.id = id
        self.gifUrl = url
    }
    
    // MARK: - Equatable Protocol
    
    static func ==(lhs: Gif, rhs: Gif) -> Bool {
        
        if lhs.title == rhs.title {
            return true
        }
        return false
    }
}
