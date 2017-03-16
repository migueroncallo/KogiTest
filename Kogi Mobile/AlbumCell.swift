//
//  AlbumCell.swift
//  Kogi Mobile
//
//  Created by Miguel Roncallo on 3/16/17.
//  Copyright © 2017 Miguel Roncallo. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
 
    @IBOutlet var albumImage: UIImageView!
    
    @IBOutlet var albumTitleLabel: UILabel!
    
    var album: Album!
    
    func config(_ album: Album){
        
        self.albumImage.layer.cornerRadius = self.albumImage.frame.width / 2
        self.albumImage.clipsToBounds = true
        self.albumImage.kf.indicatorType = .activity
        self.albumTitleLabel.text = album.name
        self.album = album
        self.albumImage.kf.setImage(with: URL(string:self.album.images[0]))
    }
}
