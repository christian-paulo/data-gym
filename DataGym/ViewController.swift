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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "nomeTreinos")
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
        newClass.dayWeek = "Segunda-feira"
        newClass.hour = "8 as 10"
        newClass.semesterSchool = "2020.1"
        do {
            try self.context.save()
        } catch {
            }
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
                                                    view,completionHandler) in
            let classToRemove =  self.items![indexPath.row]
            self.context.delete(classToRemove)
            do {
                try self.context.save()
            } catch {
            }
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
            let textfield = alert.textFields![0]
            classe.name = textfield.text
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
