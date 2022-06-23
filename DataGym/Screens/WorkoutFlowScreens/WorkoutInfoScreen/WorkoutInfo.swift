//
//  TreinoInfoScreen.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit
import CoreData

class WorkoutInfo: UIViewController, UITableViewDelegate, UITableViewDataSource, AddScreensDelegateExerc {
    func createdNewExerc() {
        fetchInfo()
    }


    @IBOutlet weak var lblNameWorkout : UILabel!
    @IBOutlet weak var tblExercisices: UITableView!

    let context: NSManagedObjectContext! = {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        return appDelegate?.persistentContainer.viewContext
    }()

    var exercises = [Exercise]()
    var name: WorkOut?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name?.nameWorkOut {
            lblNameWorkout.text = name
        }

        tblExercisices.delegate = self
        tblExercisices.dataSource = self

        fetchInfo()

        tblExercisices.rowHeight = 80
        tblExercisices.register(UINib(nibName: "ExerciseCell", bundle: nil), forCellReuseIdentifier: "ExerciseCell")
    }

    func fetchInfo() {
        do {
            self.exercises = try context.fetch(Exercise.fetchRequest())
            DispatchQueue.main.async {
                self.tblExercisices.reloadData()
            }
        } catch {

        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navi = segue.destination as? UINavigationController, let addScreens = navi.topViewController as? SheetExercInfo{
            addScreens.delegate = self
        }

        if let exercInfo = segue.destination as? SheetExercInfo, let exerc = sender as? Exercise{
            exercInfo.selectNote = exerc
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.exercises.count
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{

        let action = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, completionHnadler) in

            let exercToRemove = self.exercises[indexPath.row]
            self.context.delete(exercToRemove)
            try! self.context.save()
            self.fetchInfo()
        }

        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentItem = self.exercises[indexPath.row]
        performSegue(withIdentifier: "SheetExercInfo", sender: currentItem)

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblExercisices.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell else {
            return UITableViewCell()
        }
        let exercise = self.exercises[indexPath.row]

        cell.nomeExercise.text = exercise.nameExercise
        cell.serie.text = exercise.serie
        cell.charge.text = exercise.charge
        cell.repetition.text = exercise.repetition
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
