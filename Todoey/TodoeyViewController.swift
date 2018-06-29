//  ViewController.swift
//  Todoey
//
//  Created by Eunju Tak on 2018. 6. 29..
//  Copyright © 2018년 Eunju Tak. All rights reserved.

import UIKit

class TodoeyViewController: UITableViewController {
    
    let defalts = UserDefaults.standard

    var itemArray = ["work","day off","save money","drive"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defalts.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }

    //MARK - TavleView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    

    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    @IBAction func pressedAddButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Items", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item Button on our UIAlert
            self.itemArray.append(textField.text!)
            
            self.defalts.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat New Item!"
            textField = alertTextField
            
            
        }
       present(alert, animated: true, completion: nil)
        
    }
    
    
}

