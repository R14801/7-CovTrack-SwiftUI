//
//  SignUpController.swift
//  CovTrack
//
//  Created by Rajat Nagvenker on 10/13/21.
//

import Foundation
import UIKit
import Firebase

class SignUpController: UIViewController, UITextFieldDelegate {
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
        activityIndicator.stopAnimating()
    }

    @IBAction func SignUpButtonPressed(_ sender: UIButton) {
        loadingOverlay.alpha=0.7
        activityIndicator.startAnimating()
        if let email = emailTextField.text, let password = passTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              // ...
                if let e = error {
                    //print(e)
                    self.errorDisplayHandler(e: e)
                } else {
                    self.createItem(email: email, password: password, isLoggedIn: true)
                    self.performSegue(withIdentifier: "SignupToDash", sender: self)
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
