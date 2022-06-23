//
//  ClassesAddAlunos.swift
//  DataGym
//
//  Created by Narely Lima on 22/06/22.
//

import UIKit
import CoreData

protocol AddAlunosDelegate: AnyObject {
    func createdNewAlunos()
}
class ClassesAddAlunos: UIViewController {

    weak var delegate: AddAlunosDelegate?

    @IBOutlet weak var nomeAluno: UITextField!
    @IBOutlet weak var comorbidade: UITextField!

    var selectedNote: Students?

    let context: NSManagedObjectContext! = {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        return appDelegate?.persistentContainer.viewContext
    }()


    @IBAction func buttonSave(_ sender: Any) {
        let newAluno = Students(context: self.context)
        newAluno.name = nomeAluno.text
        newAluno.restricoes = comorbidade.text
        do {
            try self.context.save()
            print("Deu certo carai")
            self.dismiss(animated: true)
            delegate?.createdNewAlunos()
        } catch {

        }
    }

    @IBAction func buttonCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Adicionar Alunos"
        if (selectedNote != nil) {
            nomeAluno.text = selectedNote?.name
            comorbidade.text = selectedNote?.restricoes

        }

    }
}
