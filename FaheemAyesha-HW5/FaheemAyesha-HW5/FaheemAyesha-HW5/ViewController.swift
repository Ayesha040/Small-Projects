//
//  ViewController.swift
//  FaheemAyesha-HW5
//
//  Created by Ayesha Faheem on 10/10/23.
//

import UIKit

class ViewController: UIViewController ,  UITableViewDelegate, UITableViewDataSource, PizzaOrderDelegate{
    var pizzaList:[Pizza] = []
    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "TextCell"
    let pizzaOrderSegue = "pizzaOrderSegue"


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func didCreatePizza(_ pizza: Pizza) {
        pizzaList.append(pizza)
        tableView.reloadData()
    }
    
    //make a table that adds Pizzas from pizzaOrderVC
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)

        let pizza = pizzaList[indexPath.row]

        cell.textLabel?.text = pizza.pSize
        cell.detailTextLabel?.numberOfLines = 4;
        
        cell.detailTextLabel?.text = "\(pizza.crust)\n \(pizza.cheese)\n \(pizza.meat)\n \(pizza.veggies)"

        return cell
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == pizzaOrderSegue,
            let destination = segue.destination as? pizzaOrderVC
        {
            destination.delegate = self
        }
    }
    
}
