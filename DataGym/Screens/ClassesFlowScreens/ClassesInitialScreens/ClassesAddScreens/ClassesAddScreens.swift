//
//  TurmasAddScreens.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit
import CoreData

protocol AddScreensDelegate: AnyObject {
    func createdNewClass()
}

class ClassesAddScreens: UIViewController, AddAlunosDelegate {
    func createdNewAlunos() {
        fetchClass()
    }


    weak var delegate: AddScreensDelegate? // Estudar ARC

    @IBOutlet weak var nameClass: UITextField!
    @IBOutlet weak var semesterClass: UITextField!
    @IBOutlet weak var schedule: UITextField!
    @IBOutlet weak var diaSemana: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var selectedNote: Class?

    var items: [Students]?

    let context: NSManagedObjectContext! = {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        return appDelegate?.persistentContainer.viewContext
    }()

    @IBAction func saveButton(_ sender: Any) {
        let newClass = Class(context: self.context)
        newClass.name = nameClass.text
        newClass.dayWeek = diaSemana.text
        newClass.hour = schedule.text
        newClass.semesterSchool = semesterClass.text
        do {
            try self.context.save()
            print("Deu certo carai")
            self.dismiss(animated: true)
            delegate?.createdNewClass()
        } catch {

        }
    }

    @IBAction func cancelButton (_ sender: Any) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Criar Turmas"
        if (selectedNote != nil) {
            nameClass.text = selectedNote?.name
            semesterClass.text = selectedNote?.semesterSchool
            schedule.text = selectedNote?.hour
            diaSemana.text = selectedNote?.dayWeek
        }
        tableView.delegate = self
        tableView.dataSource = self
        title = "Adicionar Turma"
        tableView.rowHeight = 80
        fetchClass()
    }
    func fetchClass() {
        do {
            self.items = try context.fetch(Students.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{

            let action = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, completionHnadler) in

                let studentsToRemove = self.items![indexPath.row]
                self.context.delete(studentsToRemove)
                try! self.context.save()
                self.fetchClass()
            }

            return UISwipeActionsConfiguration(actions: [action])
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navi = segue.destination as? UINavigationController,
            let addAlunos = navi.topViewController as? ClassesAddAlunos {
            addAlunos.delegate = self
        }
    }
}
extension ClassesAddScreens: AddScreensDelegate {
    func createdNewClass() {
        fetchClass()
    }
}

extension ClassesAddScreens: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "nomeAlunos",
            for: indexPath
        ) as? AlunosCell else {
            return UITableViewCell()
        }
    let aluno = self.items![indexPath.row]
    print(aluno)
    cell.nomeCompleto.text = aluno.name
    cell.restricao.text = aluno.restricoes
    return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
}
