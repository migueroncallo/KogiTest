//
//  ArtistCell.swift
//  Kogi Mobile
//
//  Created by Miguel Roncallo on 3/16/17.
//  Copyright © 2017 Miguel Roncallo. All rights reserved.
//

import UIKit
import Kingfisher

class ArtistCell: UITableViewCell {

    @IBOutlet var artistImage: UIImageView!
    
    @IBOutlet var artistNameLabel: UILabel!
    
    @IBOutlet var artistFollowersLabel: UILabel!
    
    @IBOutlet var artistPopularityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(_ artist: Artist){
        self.artistImage.layer.cornerRadius = self.artistImage.frame.width / 2
        self.artistImage.clipsToBounds = true
        self.artistFollowersLabel.text = "Followers: \(artist.followers!)"
        self.artistNameLabel.text = artist.name!
        self.artistPopularityLabel.text = "Popularity: \(artist.popularity!)"
        if artist.images.count > 0{
            let url = URL(string: artist.images[0])
            artistImage.kf.indicatorType = .activity
            artistImage.kf.setImage(with: url!)
        }
        
        
        
    }
}
