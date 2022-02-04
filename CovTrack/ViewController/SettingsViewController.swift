//
//  SettingsViewController.swift
//  CovTrack
//
//  Created by Rajat Nagvenker on 10/23/21.
//

import Foundation
import UIKit
import CoreData

class SettingsViewController : UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    override
    func viewDidLoad() {
        navigationItem.title = ""
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cellIdentifier)
        self.tableView.dataSource = self
    }
    
    @IBAction func LogOutButtonPressed(_ sender: UIButton) {
        self.deleteLogin()
        performSegue(withIdentifier: "SettingsToLanding", sender: self)
    }
    
    @IBAction func printAllpresses(_ sender: Any) {
        self.getAllItems()
    }
    
    @IBAction func deleteAllPressed(_ sender: Any) {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            do {
                let items = try context.fetch(LogInDataItem.fetchRequest())
                for item in items {
                    context.delete(item)
                }
            } catch {
                //error handling
            }
        }
        
        
    }
    func deleteLogin() {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            do {
                let items = try context.fetch(LogInDataItem.fetchRequest())
                for item in items {
                    context.delete(item)
                    item.isLoggedIn = false
                    do {
                        try context.save()
                    } catch {
                        
                    }
                }
            } catch {
                //error handling
            }
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        let item = K.aboutAppHeading[indexPath.item]
        cell.textLabel?.text = "\(item): \(K.aboutApp[item]!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.aboutApp.count
    }
}

extension SettingsViewController: UITableViewDelegate{
    
}
