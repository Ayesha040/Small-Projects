//
//  pizzaOrderVC.swift
//  FaheemAyesha-HW5
//
//  Created by Ayesha Faheem on 10/10/23.
//

import UIKit


protocol PizzaOrderDelegate: AnyObject {
    func didCreatePizza(_ pizza: Pizza)
}

class pizzaOrderVC: UIViewController {
    weak var delegate: PizzaOrderDelegate?
    @IBOutlet weak var segCtrl: UISegmentedControl!
    @IBOutlet weak var pizzaSizeLabel: UILabel!
    @IBOutlet weak var crustLabels: UILabel!
    @IBOutlet weak var cheeseLabel: UILabel!
    @IBOutlet weak var meatLabel: UILabel!
    @IBOutlet weak var veggiesLabel: UILabel!
    
    
    
    
    var pizza = Pizza(pSize: "", crust: "", cheese: "", meat: "", veggies: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        pizza.pSize = "small"
        pizzaSizeLabel.text = ""
        crustLabels.text = ""
        cheeseLabel.text = ""
        veggiesLabel.text = ""
        meatLabel.text = ""
    }
   
    
    @IBAction func onSegmentChange(_ sender: Any) {
        //create a pizza
        
        switch segCtrl.selectedSegmentIndex {
        case 0:
            pizza.pSize = "Small"
        case 1:
            pizza.pSize = "Medium"
        case 2:
            pizza.pSize = "Large"
        default:
            pizza.pSize = "Small"
        }
        
    }
    
    
    
    @IBAction func selectCrust(_ sender: Any) {
        let alert = UIAlertController(title: "Select Crust", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Thin Crust", style: .default, handler: { (action) in
            self.pizza.crust = "Thin Crust"
        }))
        
        alert.addAction(UIAlertAction(title: "Thick Crust", style: .default, handler: { (action) in
            self.pizza.crust = "Thick Crust"
        }))
        present(alert, animated: true)
    }
    
    @IBAction func selectCheese(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select Cheese",
            message: "choose a cheese type",
            preferredStyle: .actionSheet)
        
        let regularC = UIAlertAction(title: "Regular Cheese", style: .default, handler: { (action) in
            self.pizza.cheese = "Regular Cheese"
        })
        controller.addAction(regularC)
        
        let noC = UIAlertAction(title: "No Cheese", style: .default, handler: { (action)  in
            self.pizza.cheese = "No Cheese"

        })
        controller.addAction(noC)
        
        let doubleC = UIAlertAction(title: "Double Cheese", style: .default, handler: { (action)  in
            self.pizza.cheese = "Double Cheese"

        })
        controller.addAction(doubleC)
        present(controller, animated: true)
    }
    
    @IBAction func selectMeat(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select Meat",
            message: "Choose one meat",
            preferredStyle: .actionSheet)

        let pepperoni = UIAlertAction(title: "Pepperoni", style: .default) { (action) in
            self.pizza.meat = "Pepperoni"
        }
        controller.addAction(pepperoni)

        let sausage = UIAlertAction(title: "Sausage", style: .default) { (action) in
            self.pizza.meat = "Sausage"
        }
        controller.addAction(sausage)

        let canadianBacon = UIAlertAction(title: "Canadian Bacon", style: .default) { (action) in
            self.pizza.meat = "Canadian Bacon"
        }
        controller.addAction(canadianBacon)

        present(controller, animated: true)
    }
   
    @IBAction func selectVeggies(_ sender: Any) {
        let controller = UIAlertController(
                title: "Select Veggies",
                message: "Choose your veggie",
                preferredStyle: .actionSheet)

        let mushroom = UIAlertAction(title: "Mushroom", style: .default) { (action) in
            self.pizza.veggies = "Mushroom"
        }
        controller.addAction(mushroom)

        let onion = UIAlertAction(title: "Onion", style: .default) { (action) in
            self.pizza.veggies = "Onion"
        }
        controller.addAction(onion)

        let greenOlive = UIAlertAction(title: "Green Olive", style: .default) { (action) in
            self.pizza.veggies = "Green Olive"
        }
        controller.addAction(greenOlive)

        let blackOlive = UIAlertAction(title: "Black Olive", style: .default) { (action) in
            self.pizza.veggies = "Black Olive"
        }
        controller.addAction(blackOlive)

        let none = UIAlertAction(title: "None", style: .default) { (action) in
            self.pizza.veggies = "None"
        }
        controller.addAction(none)
            present(controller, animated: true)
    }
    
    @IBAction func doneOrder(_ sender: Any) {
        if pizza.crust == "" || pizza.cheese == "" || pizza.meat == "" || pizza.veggies == "" {
            let missingIngredient = pizza.crust == "" ? "Crust" :
                                   pizza.cheese == "" ? "Cheese" :
                                   pizza.meat == "" ? "Meat" :
                                   "Veggie"
            
            let alert = UIAlertController(title: "Missing Ingredient", message: "Please select a \(missingIngredient) type.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
            delegate?.didCreatePizza(pizza)
            pizzaSizeLabel.text = "One \(pizza.pSize) pizza with:"
            crustLabels.text = pizza.crust
            cheeseLabel.text = pizza.cheese
            meatLabel.text = pizza.meat
            veggiesLabel.text = pizza.veggies
            print(pizza.pSize, pizza.crust, pizza.cheese, pizza.meat, pizza.veggies)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
