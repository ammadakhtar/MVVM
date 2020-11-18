//
//  ApiClient.swift
//  whitespectre-ios-challenge
//
//  Created by Mac on 5/29/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
class APIClient: NSObject {
    
    // MARK: - Variables
    
    var gyphArray =  [Gif]()
    var totalItemsCount = 0
    var url: URL?
    
    // MARK: - Private Methods
    
    /* The completion handler will be executed after properties data is fetched
     our completion handler will include an optional array of NSDictionaries parsed from our retrieved JSON object */
    
    func loadGyphs(isSearch: Bool, query: String, offSet: Int, completion: @escaping (GifData?) -> Void) {
        
        // unwrap our API endpoint
        
        if !isSearch {
            
            guard let url = URL(string: "\(kBaseUrl)trending?api_key=\(apiKey)&limit=\(kLimit)&offset=\(offSet)") else { return }
            self.url = url
            
        } else {
            
            let urlEncoded = "\(kBaseUrl)search?q=\(query)&api_key=\(apiKey)&limit=\(kLimit)&offset=\(offSet)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            guard let url = URL(string: urlEncoded) else { return }
            self.url = url
        }
       
        // create a session and dataTask on that session to get data/response/error
        print(url!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            
            // unwrap our returned data
            guard let unwrappedData = data else { return }
            
            do {
                
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary {
                    
                    if let gyphs = responseJSON.value(forKeyPath: "data") as? [Dictionary<String, AnyObject>] {
                        self.gyphArray.removeAll()
                        
                        for gyph in gyphs {
                            let gyph = Gif(gyphDict: gyph)
                            self.gyphArray.append(gyph)
                        }
                    }
                    
                    if let pagination = responseJSON.value(forKey: "pagination") as? Dictionary<String, AnyObject> {
                        
                        if let totalCount = pagination["total_count"] as? Int {
                            self.totalItemsCount = totalCount
                        }
                    }
                    
                    return completion(GifData(gyphArray: self.gyphArray, paginationCount: self.totalItemsCount))
                }
                
            } catch {
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
