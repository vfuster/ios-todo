//
//  ViewController.swift
//  ToDo
//
//  Created by Valeria Fuster on 11/10/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    private var tasks: [Task] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: DELEGATE
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = tasks[indexPath.row]
        let taskToBeUpdated = Task(name: selectedTask.name, isConcluded: !selectedTask.isConcluded)
        tasks[indexPath.row] = taskToBeUpdated
        
        tableView.reloadData()
    }
    
    // MARK: DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.name
        
        if task.isConcluded == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    @IBAction func tapAdd(_ sender: Any) {
        let alert = UIAlertController(title: "Digite a tarefa", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { [unowned alert] _ in
            if let taskName = alert.textFields![0].text {
                let task = Task(name: taskName, isConcluded: false)
                self.tasks.append(task)
                self.tableView.reloadData()
            }
        }
        alert.addAction(addAction)
        
        present(alert, animated: true, completion: nil)
    }
}

