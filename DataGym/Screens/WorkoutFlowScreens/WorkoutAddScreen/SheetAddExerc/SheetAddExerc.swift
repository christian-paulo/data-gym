//
//  SheetAddExerc.swift
//  DataGym
//
//  Created by Narely Lima on 23/06/22.
//

import UIKit
import CoreData

protocol AddExerciseDelegate: AnyObject {
    func createdNewExercise()
}

class SheetAddExerc: UIViewController {

    weak var delegate: AddExerciseDelegate?

    @IBOutlet weak var nameExercise: UITextField!
    @IBOutlet weak var seriesNumb: UITextField!
    @IBOutlet weak var repeticoes: UITextField!
    @IBOutlet weak var cargaMaq: UITextField!
    var selectedNote: Exercise?

    let context: NSManagedObjectContext! = {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        return appDelegate?.persistentContainer.viewContext
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
            title = "Adicionar Exercícios"
            if (selectedNote != nil) {
                nameExercise.text = selectedNote?.nameExercise
                seriesNumb.text = selectedNote?.serie
                repeticoes.text = selectedNote?.repetition
                cargaMaq.text = selectedNote?.charge
            }
    }
    @IBAction func saveButtonExercise(_ sender: Any) {
            let newAExercise = Exercise(context: self.context)
            newAExercise.nameExercise = nameExercise.text
            newAExercise.serie = seriesNumb.text
            newAExercise.repetition = repeticoes.text
            newAExercise.charge = cargaMaq.text
            do {
                try self.context.save()
                print("Deu certo carai")
                self.dismiss(animated: true)
                delegate?.createdNewExercise()
            } catch {
            }
    }

    @IBAction func buttonCancelExercise(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
