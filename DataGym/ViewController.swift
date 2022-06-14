//
//  ViewController.swift
//  DataGym
//
//  Created by Christian Paulo on 28/05/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [Class]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ClassCell")
        fetchClass()
    }
    func fetchClass() {
        do {
            self.items = try context.fetch(Class.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
        }
    }
       @IBAction func addTapped(sender: Any) {
        let alert = UIAlertController(title: "Add Class", message: "Whats ir their name?", preferredStyle: .alert)
        alert.addTextField()

        let submitButton = UIAlertAction(title: "Add", style: .default) {
            (action) in

           let textfield = alert.textFields![0]

            // TODO: Create a class object

            let newClass = Class(context: self.context)
            newClass.name = textfield.text
            newClass.day_week = "Segunda-feira"
            newClass.hour = "8 as 10"
            newClass.semester_school = "2020.1"


            //TODO: save to data

            do {
                try self.context.save()
            } catch {

            }
            //re-fecth the data
            
            self.fetchClass()

        }

        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) {
            (action) in
            self.fetchClass()
        }
        alert.addAction((submitButton))
        alert.addAction((cancelButton))

        self.present(alert, animated: true, completion: nil)

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action,
                                                                                 view, completionHandler) in
            
            //TODO: WHICH CLASS TO REMOVE
            let classToRemove =  self.items![indexPath.row]
            //TODO: REMOVE THE CLASS
            self.context.delete(classToRemove)
            //TODO: SAVE THE DATA
            do {
                try self.context.save()
            } catch {
                
            }
            
            //TODO: RE-FETCH THE DATA
            self.fetchClass()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for:indexPath)
        let classe = self.items![indexPath.row]
        cell.textLabel?.text = classe.name
        return cell
    }
    
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let classe = self.items![indexPath.row]
        let alert = UIAlertController(title: "Edit Person", message: "Edit name: ", preferredStyle: .alert)
        alert.addTextField()

        let textfield = alert.textFields![0]
        textfield.text = classe.name
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            
            //GET THE TEXTFIELD FOR THE ALERT
            let textfield = alert.textFields![0]
            
            //EDIT NAME PROPERTY OF CLASS OBJECT
            classe.name = textfield.text

            //SAVE THE DATA
            
            do {
                try self.context.save()
            }
            catch {
                
            }
            self.fetchClass()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in

            self.fetchClass()
        }
        alert.addAction(saveButton)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}
