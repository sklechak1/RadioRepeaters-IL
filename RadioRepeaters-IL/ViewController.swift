//
//  ViewController.swift
//  RadioRepeaters-IL
//
//  Created by student on 3/9/19.
//  Copyright © 2019 Sean Klechak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
 
    
    let sectionsTableId = "SectionsTableIdentifer"
    var callsigns: [String: [String]]!
    var keys: [String]!
    var searchController: UISearchController!
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionsTableId)
        let path = Bundle.main.path(forResource: "Repeaters", ofType: "plist")
        let callsignsDict = NSDictionary(contentsOfFile: path!)
        callsigns = (callsignsDict as! [String: [String]])
        keys = (callsignsDict!.allKeys as! [String]).sorted()
        
      // Begin search function
        let resultsController = SearchResultsController()
        resultsController.callsigns = callsigns
        resultsController.keys = keys
        searchController = UISearchController(searchResultsController: resultsController)
        
        let searchBar = searchController.searchBar
        searchBar.scopeButtonTitles = ["All Information ", "Callsign Display"]
        searchBar.placeholder = "Enter a Search Term"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController
    }
    
    // MARK: Table View Data Source Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let callSignSection = callsigns[key]!
        return callSignSection.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionsTableId, for: indexPath)
            as UITableViewCell
        let key = keys[indexPath.section]
        let callSignSection = callsigns[key]!
        cell.textLabel?.text = callSignSection[indexPath.row]
        
        return cell
    }
    
}

