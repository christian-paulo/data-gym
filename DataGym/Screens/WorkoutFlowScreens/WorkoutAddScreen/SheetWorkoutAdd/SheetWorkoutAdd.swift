//
//  TreinoDetailScreen.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit
import CoreData

protocol AddWorkOutDelegateSheet: AnyObject {
    func createdNewWorkout()
}

class SheetWorkoutAdd: UIViewController {
    weak var delegate: AddWorkOutDelegateSheet?

    @IBOutlet weak var nameWorkout: UITextField!
    @IBOutlet weak var exercises: UITableView!
    var selectedNote: WorkOut?

    var items: [Exercise]?

    let context: NSManagedObjectContext! = {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        return appDelegate?.persistentContainer.viewContext
    }()

    @IBAction func saveButton(_ sender: Any) {
        let newWorkout = WorkOut(context: self.context)
        newWorkout.nameWorkOut = nameWorkout.text
        do {
            try self.context.save()
            print("Deu certo carai")
            self.dismiss(animated: true)
            delegate?.createdNewWorkout()
        } catch {

        }
    }

    @IBAction func cancelButton (_ sender: Any) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        title = "Criar Treinos"
        if (selectedNote != nil) {
            nameWorkout.text = selectedNote?.nameWorkOut
        }
        exercises.delegate = self
        exercises.dataSource = self
        title = "Adicionar Exercício"
        exercises.rowHeight = 80
        fetchExercise()
        exercises.register(
            UINib(nibName: "ExerciseCell", bundle: nil),
            forCellReuseIdentifier: "ExerciseCell"
        )
    }
    func fetchExercise() {
        do {
            self.items = try context.fetch(Exercise.fetchRequest())
            DispatchQueue.main.async {
                self.exercises.reloadData()
            }
        } catch {
        }
    }
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            let exercToRemove = self.items![indexPath.row]
            self.context.delete(exercToRemove)
            try? self.context.save()
            self.fetchExercise()
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navi = segue.destination as? UINavigationController,
           let addExerc = navi.topViewController as? SheetAddExerc {
            addExerc.delegate = self
        }
    }
}

extension SheetWorkoutAdd: AddExerciseDelegate {
    func createdNewExercise() {
        fetchExercise()
    }
}

extension SheetWorkoutAdd: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ExerciseCell",
            for: indexPath
        ) as? ExerciseCell else {
            return UITableViewCell()
        }
        let exercise = self.items![indexPath.row]
        print(exercise)
        cell.nomeExercise.text = exercise.nameExercise
        cell.charge.text = exercise.charge
        cell.serie.text = exercise.serie
        cell.repetition.text = exercise.repetition
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
}
