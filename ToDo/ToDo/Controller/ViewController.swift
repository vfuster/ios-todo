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
            let attributes: [NSAttributedString.Key: Any] = [.strikethroughStyle: true]
            let attributeString = NSAttributedString(string: task.name, attributes: attributes)
            cell.textLabel?.attributedText = attributeString
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    @IBAction func tapAdd(_ sender: Any) {
        // Cria o alerta
        let alert = UIAlertController(title: "Digite a tarefa", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        // Ações do alerta
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { [unowned alert] _ in
            if let taskName = alert.textFields![0].text {
                let task = Task(name: taskName, isConcluded: false)
                self.tasks.append(task)
                self.tableView.reloadData()
            }
        }
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        // show alerta
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapSort(_ sender: Any) {
        
        let tasksOrdenadas = tasks.sorted { $0 > $1 }
        tasks = tasksOrdenadas
        
        tableView.reloadData()
    }
    
}

