//
//  ViewController.swift
//  FaheemAyesha-HW5
//
//  Created by Ayesha Faheem on 10/10/23.
//

import UIKit
import CoreData
import FirebaseAuth

let defaults = UserDefaults.standard
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class ViewController: UIViewController ,  UITableViewDelegate, UITableViewDataSource, PizzaOrderDelegate{
    var pizzaList:[PizzaOrders] = []
    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "TextCell"
    let pizzaOrderSegue = "pizzaOrderSegue"


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchPizzaOrders()
    }
    
    func retrievePizzas() -> [NSManagedObject] {
        let fetchRequest: NSFetchRequest<PizzaOrders> = PizzaOrders.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }

    func fetchPizzaOrders() {
        if let pizzaOrders = retrievePizzas() as? [PizzaOrders] {
            pizzaList = pizzaOrders
            tableView.reloadData()
        }
    }
    
    
    func didCreatePizza(_ pizza: Pizza) {
        let newPizzaOrder = PizzaOrders(context: context)
        newPizzaOrder.pSize = pizza.pSize
        newPizzaOrder.crust = pizza.crust
        newPizzaOrder.cheese = pizza.cheese
        newPizzaOrder.meat = pizza.meat
        newPizzaOrder.veggies = pizza.veggies

        appDelegate.saveContext() 

        fetchPizzaOrders() // Update the table view
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pizzaOrderToDelete = pizzaList[indexPath.row]
            context.delete(pizzaOrderToDelete) // Delete the object from Core Data
            pizzaList.remove(at: indexPath.row) // Remove it from your data source array
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try context.save() // Save the context to persist the deletion
            } catch {
                print("Error saving context after deletion: \(error)")
            }
        } else if editingStyle == .insert {
            // Handle insert operation if needed.
        }
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
        
        cell.detailTextLabel?.text = "\(pizza.crust!)\n \(pizza.cheese!)\n \(pizza.meat!)\n \(pizza.veggies!)"

        return cell
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == pizzaOrderSegue,
            let destination = segue.destination as? pizzaOrderVC
        {
            destination.delegate = self
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController")
            loginVC?.modalPresentationStyle = .fullScreen
            self.present(loginVC!, animated: true, completion: {
                self.navigationController?.popToRootViewController(animated: false)
                self.tabBarController?.selectedIndex = 0
            })
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    
    
    
}
