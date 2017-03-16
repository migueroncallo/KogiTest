//
//  Album.swift
//  Kogi Mobile
//
//  Created by Miguel Roncallo on 3/16/17.
//  Copyright © 2017 Miguel Roncallo. All rights reserved.
//

import Foundation
import SwiftyJSON

class Album{
    var name: String!
    var images = [String]()
    var externalUrl: String!
    
    func albumFromJson(_ json: JSON) -> Album{
        let album = Album()
        
        album.name = json["name"].stringValue
        album.externalUrl = json["external_urls"]["spotify"].stringValue
        for  (_,subJson):(String, JSON) in json["images"] {
            album.images.append(subJson["url"].stringValue)
        }
        
        return album
    }
}
