//
//  DataService.swift
//  Kogi Mobile
//
//  Created by Miguel Roncallo on 3/16/17.
//  Copyright © 2017 Miguel Roncallo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Artist{
    var name: String!
    var images = [String]()
    var followers: Int!
    var popularity: Int!
    var id: String!
    
    func artistFromJson(_ json: JSON)-> Artist{
        
        let artist = Artist()
        
        artist.name = json["name"].stringValue
        artist.followers = json["followers"]["total"].intValue
        
        for  (_,subJson):(String, JSON) in json["images"] {
            artist.images.append(subJson["url"].stringValue)
        }
        
        artist.popularity = json["popularity"].intValue
        artist.id = json["id"].stringValue
        
        return artist
        
    }
    
}
