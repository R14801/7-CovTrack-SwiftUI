//
//  LogInController.swift
//  CovTrack
//
//  Created by Rajat Nagvenker on 10/13/21.
//

import Foundation
import UIKit
import Firebase
import CoreData

class LogInController: UIViewController, UITextFieldDelegate  {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loadingOverlay: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passTextField.delegate = self
        loadingOverlay.alpha = 0
    }

    @IBAction func LogInButtonPressed(_ sender: UIButton) {
        loadingOverlay.alpha = 0.7
        activityIndicator.startAnimating()
        if let email = emailTextField.text, let password=passTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
              // ...
                if let e = error {
                    self?.errorDisplayHandler(e: e)
                } else {
                    //print("Log In Success")
                    self?.createItem(email: email, password: password, isLoggedIn: true)
                    self?.activityIndicator.stopAnimating()
                    self?.performSegue(withIdentifier: "LoginToDash", sender: self)
                }
            }
        }
    }
    
    func errorDisplayHandler(e: Error) {
        let uialert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(uialert, animated: true, completion: nil)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
