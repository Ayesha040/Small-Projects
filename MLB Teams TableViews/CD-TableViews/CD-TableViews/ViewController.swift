//
//  ViewController.swift
//  CD-TableViews
//
//  Created by bulko on 9/15/23.
//

import UIKit

public let teams = [
    "Braves", "Marlins", "Phillies", "Mets", "Nationals",
    "Pirates", "Brewers", "Reds", "Cubs", "Cardinals",
    "Diamondbacks", "Dodgers", "Giants", "Padres", "Rockies",
    "Rays", "Orioles", "Yankees", "Blue Jays", "Red Sox",
    "Twins", "Guardians", "White Sox", "Tigers", "Royals",
    "Rangers", "Astros", "Angels", "Mariners", "Athletics"
]

public let cities = [
    "Atlanta", "Miami", "Philadelphia", "New York", "Washington",
    "Pittsburgh", "Milwaukee", "Cincinnati", "Chicago", "St. Louis",
    "Arizona", "Los Angeles", "San Francisco", "San Diego", "Colorado",
    "Tampa Bay", "Baltimore", "New York", "Toronto", "Boston",
    "Minnesota", "Cleveland", "Chicago", "Detroit", "Kansas City",
    "Texas", "Houston", "Los Angeles", "Seattle", "Oakland"
]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    let teamSegueIdentifier = "TeamSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        let row = indexPath.row
        cell.textLabel?.text = teams[row]
        
        if indexPath.row < 15 {
            cell.detailTextLabel?.text = "National League"
        } else {
            cell.detailTextLabel?.text = "American League"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        print(teams[row])
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.row == 17 ? nil : indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == teamSegueIdentifier,
           let destination = segue.destination as? TeamViewController,
           let teamIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.teamName = teams[teamIndex]
        }
    }

}

