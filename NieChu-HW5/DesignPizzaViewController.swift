//
//  DesignPizzaViewController.swift
//  NieChu-HW5
//
//  Created by Chu Nie on 10/14/22.
//

import UIKit

protocol MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(myData: String)
}

class DesignPizzaViewController: UIViewController {
    
    @IBOutlet weak var pizzaSize: UISegmentedControl!
    @IBOutlet weak var summaryTextLabel: UILabel!
    
    var size:String = "small"
    var crust: String = ""
    var cheese: String = ""
    var meat: String = ""
    var veggies:String = ""
    
    var delegate: MyDataSendingDelegateProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectPizzaSize(_ sender: Any) {
        switch pizzaSize.selectedSegmentIndex {
        case 0:
            size = "small"
        case 1:
            size = "medium"
        case 2:
            size = "large"
        default:
            size = "small"
        }
    }
    
    @IBAction func crustButtonPressed(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select Crust",
            message: "Choose a crust type:",
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
            title: "Thin crust",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.crust = "thin crust"
            }))
        controller.addAction(UIAlertAction(
            title: "Thick crust",
            style: .default,
            handler: {(action: UIAlertAction!) in
                self.crust = "thick crust"
            }))
        present(controller, animated: true)
    }
    
    @IBAction func cheeseButtonPressed(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select Cheese",
            message: "Choose a cheese type:",
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
            title: "Regular cheese",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.cheese = "regular cheese"}))
        controller.addAction(UIAlertAction(
            title: "No cheese",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.cheese = "no cheese"}))
        controller.addAction(UIAlertAction(
            title: "Double cheese",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.cheese = "double cheese"}))
        present(controller, animated: true)
    }
    @IBAction func meatButtonPressed(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select meat",
            message: "Choose one meat:",
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
            title: "Pepperoni",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.meat = "pepperoni"}))
        controller.addAction(UIAlertAction(
            title: "Sausage",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.meat = "sausage"}))
        controller.addAction(UIAlertAction(
            title: "Canadian Bacon",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.meat = "canadian bacon"}))
        present(controller, animated: true)
    }
    
    @IBAction func veggiesButtonPressed(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select veggies",
            message: "Choose your veggies:",
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
            title: "Mushroom",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.veggies = "mushroom"}))
        controller.addAction(UIAlertAction(
            title: "Onion",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.veggies = "onion"}))
        controller.addAction(UIAlertAction(
            title: "Green Olive",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.veggies = "green olive"}))
        controller.addAction(UIAlertAction(
            title: "Black Olive",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.veggies = "black olive"}))
        controller.addAction(UIAlertAction(
            title: "None",
            style: .default,
            handler: { [self](action: UIAlertAction!) in
                self.veggies = "none"}))
        present(controller, animated: true)

    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        var type:String = ""
        if (crust == ""){
            type = "crust"
        }else if(cheese == ""){
            type = "cheese"
        }else if(meat == ""){
            type = "meat"
        }else if(veggies == ""){
            type = "veggies"
        }
        if (type.count != 0){
            let controller = UIAlertController(
                title: "Missing ingredient",
                message: "please select a \(type) type",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "OK",
                style: .default))
            present(controller, animated: true)
        }else{
            let summary = "One \(size) pizza with: \n  \(crust) \n  \(cheese) \n  \(meat) \n  \(veggies)"
            let shortSummary = "\(size)\n \(crust) \n \(cheese)\n \(meat)\n \(veggies)"
            
            summaryTextLabel.numberOfLines = 5
            summaryTextLabel.text = summary
            self.delegate?.sendDataToFirstViewController(myData: shortSummary)
        }
    }
}
