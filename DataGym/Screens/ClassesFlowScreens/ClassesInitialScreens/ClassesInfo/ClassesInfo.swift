//
//  TurmasDetailScreen.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit
import CoreData

class ClassesInfo: UIViewController, UITableViewDelegate, UITableViewDataSource, AddAlunosDelegate {
    func createdNewAlunos() {
        fetchStudent()
    }

    weak var delegate: AddAlunosDelegate?

    @IBOutlet weak var lblNameturma: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var tblAlunos: UITableView!

    let context: NSManagedObjectContext! = {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        return appDelegate?.persistentContainer.viewContext
    }()

    var alunos : [Students]?
    var name: Class?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name!.name {
            lblNameturma?.text = name
        }
        if let hour = name!.hour {
            lblHour?.text = hour
        }
        if let dayWeek = name!.dayWeek {
            lblDay?.text = dayWeek
        }

        tblAlunos?.delegate = self
        tblAlunos?.dataSource = self

        fetchStudent()

        tblAlunos?.rowHeight = 80
    }

    func fetchStudent() {
        do {
            self.alunos = try context.fetch(Students.fetchRequest())
            DispatchQueue.main.async{
                self.tblAlunos?.reloadData()
            }
        } catch {
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navi = segue.destination as? UINavigationController, let addAlunos = navi.topViewController as? ClassesInfo {
            addAlunos.delegate = self
        }
        if let alunoInfo = segue.destination as? StudentInfo, let alunos = sender as? Students{
            alunoInfo.aluno = alunos
        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.alunos!.count
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{

        let action = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, completionHnadler) in

            let exercToRemove = self.alunos?[indexPath.row]
            self.context.delete(exercToRemove!)
            try! self.context.save()
            self.fetchStudent()
        }

        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentItem = self.alunos?[indexPath.row]
        performSegue(withIdentifier: "StudentInfo", sender: currentItem)

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblAlunos.dequeueReusableCell(withIdentifier: "AlunosCell", for: indexPath) as? AlunosCell else {
            return UITableViewCell()
        }
        let aluno = self.alunos![indexPath.row]
        print(aluno)
        cell.nomeCompleto.text = aluno.name
        cell.restricao.text = aluno.restricoes

        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
