//
//  Pizza.swift
//  FaheemAyesha-HW5
//
//  Created by Ayesha Faheem on 10/20/23.
//

import UIKit
class Pizza {
    var pSize: String
    var crust: String
    var cheese: String
    var meat: String
    var veggies: String
    
    init(pSize: String, crust: String, cheese: String, meat: String, veggies: String) {
        self.pSize = pSize
        self.crust = crust
        self.cheese = cheese
        self.meat = meat
        self.veggies = veggies
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


