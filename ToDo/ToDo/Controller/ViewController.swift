//
//  ViewController.swift
//  ToDo
//
//  Created by Valeria Fuster on 11/10/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
  
    private var tasks: [String] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
    }
    
    // MARK: DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task
        
        return cell
    }
    
    @IBAction func tapAdd(_ sender: Any) {
        let alert = UIAlertController(title: "Digite a tarefa", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { [unowned alert] _ in
            if let task = alert.textFields![0].text {
                self.tasks.append(task)
                self.tableView.reloadData()
            }
        }
        alert.addAction(addAction)
        
        present(alert, animated: true, completion: nil)
    }
}

