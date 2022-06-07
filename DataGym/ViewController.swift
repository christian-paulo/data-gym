//
//  ViewController.swift
//  DataGym
//
//  Created by Christian Paulo on 28/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }


    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("you tapped me!")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell = tableView.dequeueReusableCell(withIdentifier:"cell",for:indexPath)
        
        cell.textLabel?.text = "HelloWorld"
        
        return cell
    
    }
    
}

