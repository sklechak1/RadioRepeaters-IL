//
//  SearchResultsController.swift
//  RadioRepeaters
//
//  Created by student on 3/9/19.
//  Copyright © 2019 Sean Klechak. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    let sectionsTableIdentifier = "SectionsTableIdentifer"
    var callsigns:[String: [String]] = [String: [String]]()
    var keys: [String] = []
    var filteredCallsigns: [String] = []
    
    private static let longNameSize = 5
    private static let shortNameButtonIndex = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: sectionsTableIdentifier)
     
    }
    
    // MARK: TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredCallsigns.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionsTableIdentifier)
        cell!.textLabel?.text = filteredCallsigns[indexPath.row]
        return cell!
    }
    
    
    // MARK: UISearchResultsUpdating Conformance
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
            filteredCallsigns.removeAll(keepingCapacity: true)
            
            if !searchString.isEmpty {
                let filter: (String) -> Bool = { callsign in
                    let nameLength = callsign.characters.count
                    if (buttonIndex == SearchResultsController.shortNameButtonIndex && nameLength >= SearchResultsController.longNameSize)
                       {
                        return false
                    }
                    
                    let range = callsign.range(of: searchString, options: NSString.CompareOptions.caseInsensitive, range: nil, locale: nil)
                    //  let range = name.rangeOfString(searchString, options:NSString.CompareOptions.CaseInsenstiveSearch
                    return range != nil
                    
                    
                }
                for key in keys {
                    let namesForKey = callsigns[key]!
                    let matches = namesForKey.filter(filter)
                    filteredCallsigns += matches
                    
                }
            }
        }
        tableView.reloadData()
    }
    
    
}




