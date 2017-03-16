//
//  AlbumDetailController.swift
//  Kogi Mobile
//
//  Created by Miguel Roncallo on 3/16/17.
//  Copyright © 2017 Miguel Roncallo. All rights reserved.
//

import UIKit

class AlbumDetailController: UIViewController {

    var artist: Artist!
    
    @IBOutlet var artistImage: UIImageView!
    
    @IBOutlet var artistNameLabel: UILabel!
    
    @IBOutlet var artistFollowersLabel: UILabel!
    
    @IBOutlet var artistPopularityLabel: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var collectionView: UICollectionView!
    
    var albums = [Album]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.artist.images.count > 0{
            artistImage.kf.indicatorType = .activity
            let url = URL(string: self.artist.images[0])
            artistImage.kf.setImage(with: url!)
        }
        self.activityIndicator.startAnimating()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isHidden = true
        
        self.artistNameLabel.text = self.artist.name
        self.artistFollowersLabel.text = "Followers: \(self.artist.followers!)"
        self.artistPopularityLabel.text = "Popularity: \(self.artist.popularity!)"
        
        DataService.sharedInstance.loadAlbums(self.artist.id) { (error, albums) in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            if let e = error{
                print(e)
            }else{
                self.albums = albums!
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button actions
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}

extension AlbumDetailController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIApplication.shared.openURL(URL(string: self.albums[indexPath.row].externalUrl)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Album Cell", for: indexPath) as! AlbumCell
        
        cell.config(self.albums[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.albums.count
    }
}
