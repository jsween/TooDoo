//
//  CategoryViewController.swift
//  TooDoo
//
//  Created by Jonathan Sweeney on 8/31/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.catReuseableCellId, for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.goToItemsSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    // MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New TooDoo Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if(textField.text != "") {
                let newCat = Category()
                newCat.name = textField.text!
                
                self.save(newCategory: newCat)
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
    func save(newCategory: Category) {
        do {
            try realm.write {
                realm.add(newCategory)
            }
        } catch {
            print("Error saving context in save items \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
}
