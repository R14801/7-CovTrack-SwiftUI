//
//  SplashScreenController.swift
//  CovTrack
//
//  Created by Rajat Nagvenker on 10/15/21.
//

import Foundation
import UIKit

class SplashScreenController: UIViewController {
    @IBOutlet weak var splashLogo: UIImageView!
    @IBOutlet weak var mainLogo: UIImageView!
    var result: Bool = false
    override func viewDidLoad() {
        //
//        _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { timer in
            
//            if self.isEntityEmpty() {
//                self.performSegue(withIdentifier: K.splashToNav, sender: self)
//            } else {
//                self.performSegue(withIdentifier: K.splashToDash, sender: self)
//            }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.segueHandler()
        })
        

//        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 1.5) {
            self.splashLogo.alpha = 0.0
            self.mainLogo.alpha = 1.0
        }
    }
    
    func animateLogo() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
        splashLogo.layer.add(animation, forKey: nil)
        
    }
    func reverseAnimateLogo() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        animation.beginTime = CACurrentMediaTime()
        mainLogo.layer.add(animation, forKey: nil)
        
    }
    
    func segueHandler() {
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
    }
}

