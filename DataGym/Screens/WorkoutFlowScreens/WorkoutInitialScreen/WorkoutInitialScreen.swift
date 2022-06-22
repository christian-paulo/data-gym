//
//  TreinoInitialScreen.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit
import CoreData

class WorkoutInitialScreen: UIViewController {
    @IBOutlet var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [WorkOut]?
    override func viewDidLoad() {
            super.viewDidLoad()
            title = "Treinos"
    }
    func fetchClass() {
        do {
            self.items = try context.fetch(WorkOut.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
        }
    }
}
extension WorkoutInitialScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            let workOutToRemove =  self.items![indexPath.row]
            self.context.delete(workOutToRemove)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkOutCell", for:indexPath)
        let treinos = self.items![indexPath.row]
        cell.textLabel?.text = treinos.nameWorkOut
        return cell
    }
}
