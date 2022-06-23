//
//  TurmasInicialScreen.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit
import CoreData

class ClassesInitialScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [Class]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = "Turmas"
        tableView.rowHeight = 80
        fetchClass()
        tableView.register(UINib(nibName:"ClassCell", bundle: nil),  forCellReuseIdentifier: "Classcell")
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navi = segue.destination as? UINavigationController,
            let addScreens = navi.topViewController as? ClassesAddScreens {
            addScreens.delegate = self
        }

        if let classInfo = segue.destination as? ClassesInfo, let classes = sender as? Class{
            classInfo.name = classes
        }
    }


}

extension ClassesInitialScreen: AddScreensDelegate {
    func createdNewClass() {
        fetchClass()
    }
}

extension ClassesInitialScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ClassCell",
            for: indexPath
        ) as? ClassCell else {
            return UITableViewCell()
        }
        let classe = self.items[indexPath.row]
        print(classe)
        cell.nomeTurma.text = classe.name
        cell.horario.text = classe.hour
        cell.diaSemana.text = classe.dayWeek
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentItem = self.items[indexPath.row]
        performSegue(withIdentifier: "ClassesInfo", sender: currentItem)

    }

    
}
