//
//  ViewController.swift
//  ToDo
//
//  Created by Valeria Fuster on 11/10/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    private let key = "key-tasks"
    private var tasks: [Task] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        readTasksFromUserDefaults()
        tableView.reloadData()
    }
    
    // MARK: DELEGATE
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = tasks[indexPath.row]
        let taskToBeUpdated = Task(name: selectedTask.name, isConcluded: !selectedTask.isConcluded)
        tasks[indexPath.row] = taskToBeUpdated
     
        saveTasksOnUserDefaults()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            
            let selectedTasks = self?.tasks[indexPath.row]
           
            if selectedTasks?.isConcluded == true {
                self?.tasks.remove(at: indexPath.row)
                self?.saveTasksOnUserDefaults()
                self?.tableView.reloadData()
                completionHandler(true)
            } else {
                // alerta deletar
                let alert = UIAlertController(title: "Ação necessária", message: "Você quer realmente deletar", preferredStyle: .alert)
                
                let addActionDelete = UIAlertAction(title: "Deletar", style: .default) { _ in
                    self?.tasks.remove(at: indexPath.row)
                    self?.saveTasksOnUserDefaults()
                    self?.tableView.reloadData()
                    completionHandler(true)
                }
                alert.addAction(addActionDelete)
                
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
                    completionHandler(true)
                }
                
                alert.addAction(cancelAction)
                
                self?.present(alert, animated: true, completion: nil)
            }
    
        }
        
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
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
                self.saveTasksOnUserDefaults()
                self.tableView.reloadData()
            }
        }
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

        // show alert
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapSort(_ sender: Any) {
        let sortedTasks = tasks.sorted { $0 > $1 }
        tasks = sortedTasks
        saveTasksOnUserDefaults()
        tableView.reloadData()
    }
    
    private func saveTasksOnUserDefaults() {
        let encoder = JSONEncoder()
        
        if let encodedTasks = try? encoder.encode(tasks) {
            let tasksDefaults = UserDefaults.standard
            tasksDefaults.set(encodedTasks, forKey: key)
        }
    }
    
    private func readTasksFromUserDefaults() {
        let decoder = JSONDecoder()
        let userDefaults = UserDefaults.standard
        
        if let data = userDefaults.value(forKey: key) as? Data,
            let tasksDecoded = try? decoder.decode([Task].self, from: data) {
            self.tasks = tasksDecoded
        }
    }

}
