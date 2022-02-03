//
//  CovidModel.swift
//  CovTrack
//
//  Created by Rajat Nagvenker on 10/15/21.
//

import Foundation

struct CovidModel: Codable {
    var country: String
    var cases: Int
    var todayCases: Int
    var deaths: Int
    var todayDeaths: Int
    var recovered: Int
    var todayRecovered: Int
}
