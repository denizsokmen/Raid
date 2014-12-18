//
//  ViewController.swift
//  FriendFeedHW
//
//  Created by student7 on 12/11/14.
//  Copyright (c) 2014 student7. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, HTTPResponseDelegate, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let waitImage =  UIImage(named: "frog.jpg")
    var entries: [CellEntry] = []
    var filteredEntries: [CellEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //collectionView.delegate = self
        //collectionView.dataSource = self
        //collectionView.registerClass(FriendCell.self, forCellWithReuseIdentifier: "viewCell")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchText = searchBar.text
        if searchText == nil || searchText == "" {
            filteredEntries = entries
        } else {
            filteredEntries = entries.filter( {
                $0.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch) != nil
            })
        }
        
        collectionView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        
        let searchText = searchBar.text
        if searchText == nil || searchText == "" {
            filteredEntries = entries
        } else {
            filteredEntries = entries.filter( {
                $0.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch) != nil
            })
        }
      
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        search(searchBar.text)
        searchBar.text = ""
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredEntries.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("viewCell", forIndexPath: indexPath) as FriendCell
        let row = indexPath.row
        
       
        cell.name.text = filteredEntries[row].name
        cell.image.image = waitImage
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            if let nsurl = NSURL(string: "http://friendfeed-api.com/v2/picture/"+self.filteredEntries[row].image) {
                if let nsdata = NSData(contentsOfURL: nsurl) {
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.image.image = UIImage(data: nsdata)!
                    })
                }
            }
        })
        
        
        
        return cell
    }
    
    
    
    func search(query: String) {
        var request = HTTPLayer(responseDelegate: self)
        request.invokeGet("http://friendfeed-api.com/v2/search?q="+query)
        
    }
    
    @IBAction func sortByUser(sender: UIButton) {
        filteredEntries = sorted (filteredEntries, { ( s1: CellEntry, s2: CellEntry ) -> Bool in
            return s1.name < s2.name})
        collectionView.reloadData()
    }
    
    
    @IBAction func sortByDate(sender: UIButton) {
        filteredEntries = sorted (filteredEntries, { ( s1: CellEntry, s2: CellEntry ) -> Bool in
            return s1.date.timeIntervalSince1970 < s2.date.timeIntervalSince1970})
        collectionView.reloadData()
    }
    
    
    func responseJSON(response:JSON) {
        entries = []
        filteredEntries = []
        if let entries = response["entries"].asArray {
            for entry in entries {
                var cell = CellEntry(name: entry["from"]["name"].asString!, body: entry["body"].asString!, image: entry["from"]["id"].asString!, date: entry["date"].asString!)
                println(cell)
                self.entries.append(cell)
                self.filteredEntries.append(cell)
            }
        }
        
        collectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "details" {
            var indexPath: NSIndexPath? = collectionView.indexPathForCell(sender as UICollectionViewCell)
            let row = indexPath?.row
            let vc = segue.destinationViewController as EntryViewController
            vc.cell = entries[row!]
        }
    }


}

