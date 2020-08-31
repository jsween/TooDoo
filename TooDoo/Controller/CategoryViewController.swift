//
//  CategoryViewController.swift
//  TooDoo
//
//  Created by Jonathan Sweeney on 8/31/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.catReuseableCellId, for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: add navigation functionality
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New TooDoo Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            if(textField.text != "") {
                let newCat = Category(context: self.context)
                newCat.name = textField.text!
                
                self.categoryArray.append(newCat)
                
                self.saveCategories()
            }
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTF) in
            alertTF.placeholder = "New TooDoo Category"
            textField = alertTF
        }
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Data Manipulation Methods
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving context in save items \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from load categories \(error)")
        }
        
        tableView.reloadData()
    }
}
