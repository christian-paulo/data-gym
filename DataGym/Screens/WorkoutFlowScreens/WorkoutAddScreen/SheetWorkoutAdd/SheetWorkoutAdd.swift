//
//  TreinoDetailScreen.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit
import CoreData

protocol AddScreensDelegateSheet: AnyObject {
    func createdNewWorkout()
}

class SheetWorkoutAdd: UIViewController {
    weak var delegate: AddScreensDelegateSheet?
    @IBOutlet weak var nameWorkout: UITextField!
    @IBOutlet weak var exercises: UITableView!
    var selectedNote: WorkOut?
    
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
    }
}
