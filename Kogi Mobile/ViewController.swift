//
//  ViewController.swift
//  Kogi Mobile
//
//  Created by Miguel Roncallo on 3/16/17.
//  Copyright © 2017 Miguel Roncallo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTermLabel: UILabel!
    @IBOutlet var resultsForLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var searchBar: UISearchBar!
    
    var artists = [Artist]()
    var timer: Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
        self.searchTermLabel.isHidden = true
        self.activityIndicator.isHidden = true
        self.resultsForLabel.isHidden = true
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Supporting functions
    
    func preSearch(_ timer: Timer){
        
        searchArtist(self.searchBar.text!)
    }
    
    func searchArtist(_ searchTerm: String){
        DataService.sharedInstance.searchArtist(searchTerm) { (error, artists) in
            if let e = error{
                print(e)
            }else{
                self.resultsForLabel.isHidden = false
                self.searchTermLabel.text = self.searchBar.text!
                self.searchTermLabel.isHidden = false
                self.artists = artists!
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
                self.view.endEditing(true)
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Album Detail VC") as! AlbumDetailController
        vc.artist = self.artists[indexPath.row]
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows = \(self.artists.count)")
        return self.artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Artist Cell") as! ArtistCell
        
        cell.config(self.artists[indexPath.row])
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.artists.removeAll()
        self.resultsForLabel.isHidden = true
        self.searchTermLabel.isHidden = true
        self.tableView.isHidden = true
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
        self.view.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchBar.text!.isEmpty{
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            self.tableView.isHidden = true
            
            timer?.invalidate()
            
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.preSearch(_:)), userInfo: searchBar, repeats: false)
        }else{
            print("empty searchbar")
            self.resultsForLabel.isHidden = true
            self.searchTermLabel.isHidden = true
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.tableView.isHidden = true
            self.tableView.reloadData()
            self.view.endEditing(true)
        }
    }
}

