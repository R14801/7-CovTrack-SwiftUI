//
//  CovidController.swift
//  CovTrack
//
//  Created by Rajat Nagvenker on 10/15/21.
//

import Foundation

protocol CovidControllerDelegate {
    func didUpdateData(_ covidController: CovidController, covid: CovidData)
    func didFailWithError(error: Error)
}

struct CovidController {
    let country = "India"
    let covidURL = K.baseURL
    var delegate: CovidControllerDelegate?
    
    func fetchData() {
        performRequest(with: covidURL)
    }
    
    func fetchData(country: String) {
        let covidURL = "\(K.baseURL2)/\(K.countryCode[country]!)?yesterday=true&strict=true"
        performRequest(with: covidURL)
    }
    
    func performRequest(with urlString: String) {
        //1. Create URL
        if let url = URL(string: urlString) {
            
            //2. Create session
            let session = URLSession(configuration: .default)
            
            //3. Assign task to session
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let covid = self.parseJSON(safeData){
//                        self.delegate?.didUpdateWeather(self, weather: weather)
                        self.delegate?.didUpdateData(self, covid: covid)
                    }
                }
            }
            //4.Perform task
            task.resume()
        }
    }
    
    
    func parseJSON(_ covidData: Data) -> CovidData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CovidData.self, from: covidData)
            let country = decodedData.country
            let cases = decodedData.cases
            let todayCases = decodedData.todayCases
            let deaths = decodedData.deaths
            let todayDeaths = decodedData.todayDeaths
            let recovered = decodedData.recovered
            let todayRecovered = decodedData.todayRecovered
            let covid = CovidData(country: country, cases: cases, todayCases: todayCases, deaths: deaths, todayDeaths: todayDeaths, recovered: recovered, todayRecovered: todayRecovered)
            return covid
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
