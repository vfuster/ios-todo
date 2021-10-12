//
//  ViewController.swift
//  ToDo
//
//  Created by Valeria Fuster on 11/10/21.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapAdd(_ sender: Any) {
        let alert = UIAlertController(title: "Digite a tarefa", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { [unowned alert] _ in
            let task = alert.textFields![0].text
            print(task)
        }
        alert.addAction(addAction)
        
        present(alert, animated: true, completion: nil)
    }
}

