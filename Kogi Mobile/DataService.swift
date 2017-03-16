//
//  DataService.swift
//  Kogi Mobile
//
//  Created by Miguel Roncallo on 3/16/17.
//  Copyright © 2017 Miguel Roncallo. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class DataService{
    
    static let sharedInstance = DataService()
    var baseUrl = "https://api.spotify.com/v1/"
    var artists = [Artist]()
    var albums = [Album]()
    
    
    func searchArtist(_ searchTerm: String, cb: @escaping (NSError?, [Artist]?)->()){
        
        print("Searching for \(searchTerm)")
        let url = URL(string: "\(baseUrl)search")
        
        let parameters = ["q": searchTerm,
                          "type": "artist"]
        
        Alamofire.request(url!, method: .get, parameters: parameters)
        .validate()
        .responseJSON { (response) in
            print("Response \(response)")
            
            switch response.result{
            case .success:
                
                if let value = response.result.value{
                    
                    let json = JSON(value)
                    if let _ = json["artists"].null{
                        cb(NSError(
                            domain: "root",
                            code: -99,
                            userInfo: [NSLocalizedDescriptionKey:"Problems loading artists"]
                        ), nil)
                    }else{
                        
                        self.artists.removeAll()
                        
                        for  (_,subJson):(String, JSON) in json["artists"]["items"] {
                            self.artists.append(Artist().artistFromJson(subJson))
                            
                            print("New Artists")
                            print(Artist().artistFromJson(subJson))
                        }
                        
                        print("Number of artists = \(self.artists.count)")
                        cb(nil, self.artists)
                    }
                }
            case .failure(let error):
                cb(error as NSError!, nil)
            }

        }
    }
    
    func loadAlbums(_ artistId: String, cb: @escaping (NSError?, [Album]?)->()){
        
        let url = URL(string: "\(baseUrl)artists/\(artistId)/albums")
        
        Alamofire.request(url!, method: .get).validate()
        .responseJSON { (response) in
            print("Response \(response)")
            
            switch response.result{
            case .success:
                
                if let value = response.result.value{
                    
                    let json = JSON(value)
                    if let _ = json["items"].null{
                        cb(NSError(
                            domain: "root",
                            code: -99,
                            userInfo: [NSLocalizedDescriptionKey:"Problems loading albums"]
                        ), nil)
                    }else{
                        
                        self.albums.removeAll()
                        
                        for  (_,subJson):(String, JSON) in json["items"] {
                            self.albums.append(Album().albumFromJson(subJson))
                           
                        }
                        
                        print("Number of albums = \(self.artists.count)")
                        cb(nil, self.albums)
                    }
                }
            case .failure(let error):
                cb(error as NSError!, nil)
            }
        }
    }
    
}
