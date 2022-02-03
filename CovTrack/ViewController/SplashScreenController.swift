//
//  SplashScreenController.swift
//  CovTrack
//
//  Created by Rajat Nagvenker on 10/15/21.
//

import Foundation
import UIKit

class SplashScreenController: UIViewController {
    override func viewDidLoad() {
        //
        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { timer in
            
//            if self.isEntityEmpty() {
//                self.performSegue(withIdentifier: K.splashToNav, sender: self)
//            } else {
//                self.performSegue(withIdentifier: K.splashToDash, sender: self)
//            }
            var result: Bool = false
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let context = appDelegate.persistentContainer.viewContext
                
                do {
                    let items = try context.fetch(LogInDataItem.fetchRequest())
                    for item in items {
                        if item.isLoggedIn {
                            result = true
                        } else {
                            result = false
                        }
                    }
                } catch {
                    //error handling
                }
            }
            
            if result {
                self.performSegue(withIdentifier: K.splashToDash, sender: self)
            } else {
                self.performSegue(withIdentifier: K.splashToNav, sender: self)
            }
        })
    }
}
