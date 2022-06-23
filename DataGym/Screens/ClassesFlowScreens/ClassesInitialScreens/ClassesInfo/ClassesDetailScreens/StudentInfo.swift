//
//  AlunoInfo.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit

class StudentInfo: UIViewController, UITableViewDelegate, UITableViewDataSource, AddAlunosDelegate {

    weak var delegate: AddAlunosDelegate?
    func createdNewAlunos() {
        fetchLista()
    }

    @IBOutlet weak var lblNameStudent: UITextField!
    @IBOutlet weak var lblRestricoes: UITextField!
    @IBOutlet weak var tblStudentExercises: UITableView!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var lista : [Exercise]!
    var aluno: Students?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = aluno?.name {
            lblNameStudent.text = name
        }
        if let restricoes = aluno?.restricoes {
            lblRestricoes.text = restricoes
        }

        tblStudentExercises.delegate = self
        tblStudentExercises.dataSource = self

        fetchLista()
        tblStudentExercises.rowHeight = 80
        tblStudentExercises.register(UINib(nibName: "StudentExerciseCell", bundle: nil), forCellReuseIdentifier: "StudentExerciseCell")
    }

    func fetchLista() {
        do {
            self.lista = try context.fetch(Exercise.fetchRequest())
            DispatchQueue.main.async{
                self.tblStudentExercises.reloadData()
            }
        } catch {
        }
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.lista!.count
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{

        let action = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, completionHnadler) in

            let exercToRemove = self.lista[indexPath.row]
            self.context.delete(exercToRemove)
            try! self.context.save()
            self.fetchLista()
        }

        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblStudentExercises.dequeueReusableCell(withIdentifier: "StudentExerciseCell", for: indexPath) as? StudentExerciseCell else {
            return UITableViewCell()
        }
        let exerc = self.lista[indexPath.row]

        cell.name.text = exerc.nameExercise
        cell.charge.text = exerc.charge
        cell.serie.text = exerc.serie
        cell.repetition.text = exerc.repetition

        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
