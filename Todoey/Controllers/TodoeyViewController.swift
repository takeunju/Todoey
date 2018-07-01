//  ViewController.swift
//  Todoey
//
//  Created by Eunju Tak on 2018. 6. 29..
//  Copyright © 2018년 Eunju Tak. All rights reserved.

import UIKit
import CoreData

class TodoeyViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.Plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        loadItems()
    }
    
    //MARK - TavleView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //        Ternary operator
        //        value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        //       ▲ same code ▼
        //        if item.done == true{
        //            cell.accessoryType = .checkmark
        //        }else{
        //            cell.accessoryType = .none
        //        }
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //   print(itemArray[indexPath.row])
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        //          ▲ same code ▼
        //        if itemArray[indexPath.row].done == false{
        //            itemArray[indexPath.row].done = true
        //        }else{
        //            itemArray[indexPath.row].done = false
        //        }
        
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Creat New Item!"
            textField = alertTextField
            
            
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Medel Manuplation Methods
    
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array, \(error)")
            }
        }
        
        
    }
    
    
}

