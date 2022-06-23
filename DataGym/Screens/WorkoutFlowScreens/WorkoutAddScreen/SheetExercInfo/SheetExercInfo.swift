//
//  SheetExercInfo.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit
import CoreData

protocol AddScreensDelegateExerc: AnyObject {
    func createdNewExerc()
}

class SheetExercInfo: UIViewController {

    weak var delegate: AddScreensDelegateExerc?
    @IBOutlet weak var nameExercise: UITextField!
    @IBOutlet weak var charge: UITextField!
    @IBOutlet weak var serie: UITextField!
    @IBOutlet weak var repetition: UITextField!

    var selectNote: Exercise?

    let context: NSManagedObjectContext! = {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        return appDelegate?.persistentContainer.viewContext
    }()

    override func viewDidLoad(){
        super.viewDidLoad()
        if let nameExerc = selectNote?.nameExercise {
            nameExercise.text = nameExerc
        }
        if let charge1 = selectNote?.charge {
            charge.text = charge1
        }
        if let serie1 = selectNote?.serie {
            serie.text = serie1
        }
        if let rep1 = selectNote?.repetition {
            repetition.text = rep1
        }
    }
    @IBAction func saveButton(_ sender: Any) {
        let newExerc = Exercise(context: self.context)
        newExerc.nameExercise = nameExercise.text
        newExerc.serie = serie.text
        newExerc.repetition = repetition.text
        newExerc.charge = charge.text
        do {
            try self.context.save()
            print("Deu certo carai")
            self.dismiss(animated: true)
            delegate?.createdNewExerc()
        } catch {

        }
    }

    @IBAction func cancelButton (_ sender: Any) {
        self.dismiss(animated: true)
    }

}
