//
//  TableViewController.swift
//  ToDoListCoreData2
//
//  Created by Артур Дохно on 24.02.2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var tasks: [Task] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let context = getContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortDescripter = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Метод удаления
//        let contex = getContext()
//        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
//        if let object = try? contex.fetch(fetchRequest) {
//            for object in object {
//                contex.delete(object)
//            }
//        }
//
//        do {
//            try contex.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
        
    }

    @IBAction func saveTask(_ sender: Any) {
        let alertController = UIAlertController(title: "New Task",
                                                message: "Enter a new task",
                                                preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alertController.textFields?.first
            if let newTask = textField?.text {
                self.saveTask(withTitle: newTask)
                self.tableView.reloadData()
            }
        }
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func saveTask(withTitle title: String) {
        let contex = getContext()
        guard let entity = NSEntityDescription
                .entity(forEntityName: "Task", in: contex) else { return }
        
        let taskObject = Task(entity: entity, insertInto: contex)
        taskObject.title = title
        
        do {
            try contex.save()
            tasks.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title

        return cell
    }


}
