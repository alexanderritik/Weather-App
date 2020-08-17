//
//  weatherData.swift
//  Clima
//
//  Created by Ritik Srivastava on 22/07/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

//this file is used to convert the json data in to acceptable format

import Foundation

//type alsis when we want to more than two protocol
//codeable is decodable and encodable

struct WeatherData:Codable {
    let name:String
    let weather : [detail]
    let main : mainTemp
}

struct detail:Codable {
    let id: Int
    let description:String
}

struct mainTemp: Codable {
    let temp:Double
    let humidity : Int
}
