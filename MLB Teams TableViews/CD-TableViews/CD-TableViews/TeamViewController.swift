//
//  TeamViewController.swift
//  CD-TableViews
//
//  Created by bulko on 9/18/23.
//

import UIKit

class TeamViewController: UIViewController {

    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var teamName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamLabel.text = "Team selected: \(teamName)"
        let teamIndex = teams.firstIndex(of: teamName)
        cityLabel.text = "City selected: \(cities[teamIndex!])"
    }

}
