//
//  Extensions.swift
//  CovTrack
//
//  Created by Rajat Nagvenker on 1/31/22.
//

import Foundation
import UIKit
import CoreData

//extension UIViewController {
//    func save(value: String) {
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            let context = appDelegate.persistentContainer.viewContext
//
//            guard let entityDescription = NSEntityDescription.entity(forEntityName: "LoginData", in: context) else { return }
//
//            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)
//            newValue.setValue(value, forKey: "testValue")
//
//            do {
//                try context.save()
//                print("Saved: \(value)")
//            } catch {
//                print("Saving Error")
//            }
//        }
//    }
//
//    func retreiveValue() {
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            let context = appDelegate.persistentContainer.viewContext
//            let fetchRequest = NSFetchRequest<LoginData>(entityName: "LoginData")
//
//            do {
//                let results = try context.fetch(fetchRequest)
//
//                for result in results {
//                    if let testValue = result.testValue {
//                        print(testValue)
//                    }
//                }
//            } catch {
//                print("Could not retreive")
//            }
//        }
//    }
//}

extension UIViewController{
    
    func getAllItems(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            do {
                let items = try context.fetch(LogInDataItem.fetchRequest())
                for item in items {
                    print(item.email!)
                    print(item.password!)
                    print(item.isLoggedIn)
                }
            } catch {
                //error handling
            }
        }
    }
    
    func isEntityEmpty() -> Bool{
        var results: Bool = true
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            do {
                let items = try context.fetch(LogInDataItem.fetchRequest())
                for item in items {
                    if item.email != nil {
                        results = false
                    } else {
                        results = true
                    }
                }
            } catch {
                //error handling
                print("Error: \(error.localizedDescription)")
            }
        }
        return results
    }
    
    func returnItems() -> Bool {
        var result: Bool?
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            do {
                let items = try context.fetch(LogInDataItem.fetchRequest())
                if items.count != 0 {
                    result = true
                } else {
                    result = false
                }
            } catch {
                //error handling
                result = false
            }
        }
        return result!
    }
    
    func createItem(email: String, password: String, isLoggedIn: Bool){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            let newItem = LogInDataItem(context: context)
            newItem.email = email
            newItem.password = password
            newItem.isLoggedIn = true
            
            do {
                try context.save()
            } catch {
                //error handling
            }
        }
    }
    
    func updateItem(item: LogInDataItem, newEmail: String, newPassword: String) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            item.email = newEmail
            item.password = newPassword
            
            do {
                try context.save()
            } catch {
                //error handling
            }
        }
        
        func deleteItem(item: LogInDataItem) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let context = appDelegate.persistentContainer.viewContext
                
                context.delete(item)
                do {
                    try context.save()
                } catch {
                    //error handling
                }
            }
            
        }
        
        
    }
}
