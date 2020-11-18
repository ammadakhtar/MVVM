//
//  ViewModel.swift
//  whitespectre-ios-challenge
//
//  Created by Mac on 5/29/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import UIKit
class ViewModel: NSObject {
    
    // MARK :- IBOUtlets and variables
    
    /* This apiClient outlet is marked as an @IBOutlet so that we can instantiate it from the storyboard.  I mark this with a bang operator (!) since I know it will not be nil since the storyboard will be injecting it. */
    
    @IBOutlet var apiClient: APIClient!
    
    var gifs = [Gif]()
    var paginationCount = 0
        
    // MARK: - API Call Method
    
    func getGifs(isSearch: Bool, query: String, offSet: Int, completion: @escaping () -> Void) {
        
        apiClient.loadGyphs(isSearch: isSearch, query: query, offSet: offSet) { (gifDataReturned) in
            
            /* Putting this block on the main queue because our completion handler is where the data display code will happen and we don't want to block any UI code. */
            
            DispatchQueue.main.async() { [weak self] in
                
                guard let self = self else { return }
                
                if offSet == 0 {
                    self.gifs = gifDataReturned?.ghyphs ?? [Gif]()
                
                } else {
                    self.gifs.append(contentsOf: gifDataReturned?.ghyphs ?? [Gif]())
                }
                
                self.paginationCount = gifDataReturned?.pagination ?? 0
                completion()
            }
        }
    }
    
    // MARK: - Data For Collection View
    
    func numberOfItemsToDisplay(in section: Int) -> Int {
        return gifs.count
    }
    
    func glyphTiltle(for indexPath: IndexPath) -> String {
        return (gifs[indexPath.row].title)
    }
    
    func glyphId(for indexPath: IndexPath) -> String {
        return (gifs[indexPath.row].id)
    }
    
    func totalPaginationCount() -> Int {
        return paginationCount
    }
    
    func glyphUrl(for indexPath: IndexPath) -> URL? {
        
        if let url = URL(string: gifs[indexPath.row].gifUrl) {
            return url
        }
        return nil
    }
}
