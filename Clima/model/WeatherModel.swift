//
//  WeatherModel.swift
//  Clima
//
//  Created by Ritik Srivastava on 22/07/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId:Int
    let cityName:String
    let temprature:Double
    let description:String
    
    var tempratureAccurate:String{
        return String(format: "%0.1f", temprature)
    }
    
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
