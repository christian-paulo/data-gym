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

class ClassesAddScreens: UIViewController {

    weak var delegate: AddScreensDelegate? // Estudar ARC

    @IBOutlet weak var nameClass: UITextField!
    @IBOutlet weak var semesterClass: UITextField!
    @IBOutlet weak var schedule: UITextField!
    @IBOutlet weak var diaSemana: UITextField!

    var selectedNote: Class?

    let context: NSManagedObjectContext! = {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        return appDelegate?.persistentContainer.viewContext
    }()

    @IBAction func saveButton(_ sender: Any) {
        let newClass = Class(context: self.context)
        newClass.name = nameClass.text
        newClass.dayWeek = "Segunda-feira"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        if (selectedNote != nil) {
            nameClass.text = selectedNote?.name
            semesterClass.text = selectedNote?.semesterSchool
            schedule.text = selectedNote?.hour
            diaSemana.text = selectedNote?.dayWeek
        }
    }
}
