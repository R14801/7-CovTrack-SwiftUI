//
//  DashboardController.swift
//  CovTrack
//
//  Created by Rajat Nagvenker on 10/13/21.
//

import Foundation
import UIKit
import MapKit

class DashboardController: UIViewController, CovidControllerDelegate {
    
    @IBOutlet weak var SettingsButton: UIButton!
    let fields = ["Cases", "Deaths", "Recovered"]
    var fieldsData = ["Cases": 0, "Deaths": 0]
    var country = "India"
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var casesLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var numberBackground: UIView!
    @IBOutlet weak var mapNumbers: UILabel!
    
    var covidController = CovidController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- Data Setup
        covidController.delegate=self
        covidController.fetchData(country: "India")
        self.countryChaner(title: "India")

        //MARK:- UI Setup
        navigationItem.title = ""
        navigationItem.hidesBackButton=true
        countryImage.layer.cornerRadius = 25
        numberBackground.layer.cornerRadius = 15
        numberBackground.alpha = 0.75
//        let shapeLAyer = CAShapeLayer()
//        let circularPath = UIBezierPath(arcCenter: countryImage.center, radius: 50, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
//        shapeLAyer.path = circularPath.cgPath
//        view.layer.addSublayer(shapeLAyer)
        
        
        
        popUpButton.menu = UIMenu(children: [
            UIAction(title: "India", handler: {(action: UIAction) in self.countryChaner(title: "India")}),
            UIAction(title: "USA", handler: {(action: UIAction) in self.countryChaner(title: "USA")}),
            UIAction(title: "Italy", handler: {(action: UIAction) in self.countryChaner(title: "Italy")}),
            UIAction(title: "UK", handler: {(action: UIAction) in self.countryChaner(title: "UK")}),
            UIAction(title: "Russia", handler: {(action: UIAction) in self.countryChaner(title: "Russia")})
        ])
        
        popUpButton.showsMenuAsPrimaryAction = true
        
    }
    
    func didUpdateData(_ covidController: CovidController, covid: CovidData) {
        fieldsData = ["Cases": covid.todayCases, "Deaths": covid.todayDeaths, "Recovered": covid.todayRecovered]
        DispatchQueue.main.async {
            self.casesLabel.text = "Cases: \(covid.todayCases)"
            self.deathsLabel.text = "Deaths: \(covid.todayDeaths)"
            self.recoveredLabel.text = "Recovered: \(covid.todayRecovered)"
            self.mapNumbers.text = "\(covid.todayCases)"
        }
    }
    
    func didFailWithError(error: Error) {
        print("Some shit went down, fix it dbag")
        
    }
    
    let countryChangerClosure = { (action: UIAction) in
    }
    
    func countryChaner(title: String) {
//        covidController.fetchData(country: country)
        DispatchQueue.main.async {
            self.covidController.fetchData(country: title)
            if let image = UIImage(named: title) {
                self.countryImage.image = image
            }
        }
    }
    
    
}

extension DashboardController: UITableViewDelegate{
    
}

extension DashboardController {
        @IBAction func SettingsButtonPressed(_ sender: UIButton) {
            performSegue(withIdentifier: "DashboardToSettings", sender: self)
        }
}
