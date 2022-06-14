//
//  TreinoInitialScreen.swift
//  DataGym
//
//  Created by Ieda Xavier on 10/06/22.
//

import UIKit

class WorkoutInitialScreen: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Treinos"
        
        //tableview.delegate = self
        //tableview.dataSource = self
    }
}

extension WorkoutInitialScreen: UITableViewDelegate{
    
}

//extension WorkoutInitialScreen: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //TODO
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //TODO
//    }
//
//
//}
