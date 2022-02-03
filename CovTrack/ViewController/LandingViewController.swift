//
//  LandingViewController.swift
//  CovTrack
//
//  Created by Rajat Nagvenker on 10/13/21.
//

import Foundation
import UIKit

class LandingViewController: UIViewController {
    @IBOutlet weak var titleText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleText.text = titleText.text?.uppercased()
        navigationItem.hidesBackButton = true
    }


}
