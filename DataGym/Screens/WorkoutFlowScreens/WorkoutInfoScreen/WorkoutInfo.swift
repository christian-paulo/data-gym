//
//  TreinoInfoScreen.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit

class WorkoutInfo: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblNameWorkout : UILabel!
    @IBOutlet weak var tblExercisices: UITableView!

    var name: WorkOut?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var exercises = [Exercise]()

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

    @IBAction func addExerc (_ sender: Any) {
        let alert = UIAlertController(title: "Adicione um exercício", message: "Especificações do exercício", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()

        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            let nameTxt = alert.textFields![0]
            let serieTxt = alert.textFields![1]
            let repTxt = alert.textFields![2]
            let cargaTxt = alert.textFields![3]

            let newExercise = Exercise(context: self.context)

            newExercise.nameExercise = nameTxt.text
            newExercise.serie = serieTxt.text
            newExercise.charge = cargaTxt.text
            newExercise.repetition = repTxt.text

            try! self.context.save()
            self.fetchInfo()
        }


        alert.addAction(submitButton)

        self.present(alert, animated: true, completion: nil)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let workout = self.exercises[indexPath.row]

        let alert = UIAlertController(title: "Edit Exercise", message: "Edit exercises fiels", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()

        let nameTxt = workout.nameExercise
        let serieTxt = workout.serie
        let repTxt = workout.repetition
        let cargaTxt = workout.charge

        let saveButton = UIAlertAction(title: "Save", style: .default){ (action) in

            let nameTxt = alert.textFields![0]
            let serieTxt = alert.textFields![1]
            let repTxt = alert.textFields![2]
            let cargaTxt = alert.textFields![3]

            workout.nameExercise = nameTxt.text
            workout.charge = cargaTxt.text
            workout.serie = serieTxt.text
            workout.repetition = serieTxt.text

            try! self.context.save()
            self.fetchInfo()
        }

        alert.addAction(saveButton)
        self.present(alert, animated: true, completion: nil)

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblExercisices.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell else {
            return UITableViewCell()
        }
        let exercise = self.exercises[indexPath.row]
        print(exercise)
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
