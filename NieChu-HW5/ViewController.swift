//
//  ViewController.swift
//  NieChu-HW5
//
//  Created by Chu Nie on 10/14/22.
//
// Project: NieChu-HW6
// EID: cn9863
// Course: CS329E

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

let textCellIdentifier = "TextCellIdentifier"
let segueIdentifier = "designSeguesIdentifier"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var pizzaList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pizza Order"
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        func allowMultipleLines(tableViewCell:UITableViewCell) {
            tableViewCell.textLabel?.numberOfLines = 10
            tableViewCell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            }
    }
    // Core data
    func storePizza(pizza: String){
        let piz = NSEntityDescription.insertNewObject(forEntityName: "PizzaList", into: context)
        piz.setValue(pizza, forKey: "pizza")
        
        saveContext()
    }
    
    func retrievePizza(idx: Int) -> String {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PizzaList")
        var fetchedResults:[NSManagedObject]? = nil
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
            let result = fetchedResults![idx] as NSManagedObject
            let text = result.value(forKey: "pizza") as! String
            return text
        }catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    func countPizza() -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PizzaList")
        var fetchedResults:[NSManagedObject]? = nil
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
            guard let count = fetchedResults?.count as? Int else { return 0 }
            return count
        }catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
    }
    func removePizza(index: IndexPath) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PizzaList")
        var fetchedResults:[NSManagedObject]
        do {
            try fetchedResults = context.fetch(request) as! [NSManagedObject]
            let result = fetchedResults[index.row]
            context.delete(result)
            
            saveContext()
            
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Table View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            let destination = segue.destination as? DesignPizzaViewController
            destination?.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countPizza()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = mainTableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        cell.textLabel?.text = retrievePizza(idx: row)
        //pizzaList[row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        mainTableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removePizza(index: indexPath)
            mainTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ViewController: MyDataSendingDelegateProtocol{
    func sendDataToFirstViewController(myData: String) {
        //self.pizzaList.append(myData)
        storePizza(pizza: myData)
        self.mainTableView.reloadData()
    }
}
