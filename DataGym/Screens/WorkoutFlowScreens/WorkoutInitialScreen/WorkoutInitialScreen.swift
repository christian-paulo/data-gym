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
    
    var items = [WorkOut]()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            title = "Treinos"
        tableView.delegate = self
        tableView.dataSource = self
        fetchWorkout()
        tableView.register(UINib(nibName: "WorkoutCell", bundle: nil), forCellReuseIdentifier: "WorkoutCell")
    }
    func fetchWorkout() {
        do {
            self.items = try context.fetch(WorkOut.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navi = segue.destination as? UINavigationController,
           let addScreens = navi.topViewController as? SheetWorkoutAdd {
            addScreens.delegate = self
        }
        if let workoutInfo = segue.destination as? WorkoutInfo, let workout = sender as? WorkOut {
            workoutInfo.name = workout
        }
    }
}

extension WorkoutInitialScreen: AddScreensDelegateSheet {
    func createdNewWorkout() {
        fetchWorkout()
    }
}

extension WorkoutInitialScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentItem = self.items[indexPath.row]
        performSegue(withIdentifier: "WorkoutInfo", sender: currentItem)

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "WorkoutCell",
            for: indexPath
        ) as? WorkoutCell else {
            return UITableViewCell()
        }

        let workout = self.items[indexPath.row]
        print(workout)
        cell.nomeWorkout.text = workout.nameWorkOut
        return cell
    }
}
