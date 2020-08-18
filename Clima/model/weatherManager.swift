//
//  weatherManager.swift
//  Clima
//
//  Created by Ritik Srivastava on 21/07/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

//we use protocol so that it can send weather model to view controllor

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func updateFailWeather(_ error : Error)
}


struct WeatherManager {
    
    
    //    setting the delegate
    var delegate : WeatherManagerDelegate?
    
    
//     use https beacuse safe for networking
    let weatherUrl="https://api.openweathermap.org/data/2.5/weather?units=metric&appid=YOUR_API_KEY"
    
    func fetchweather(cityName:String){
        let urlString="\(weatherUrl)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
        
    }
    

    
    
    func performRequest(urlString: String){
        // 1 . Create url
        
        if let url = URL(string: urlString) {
        
        // 2 . Create a URL session
            let session=URLSession(configuration: .default)
         
        // 3 . Give the session a task
            let task = session.dataTask(with: url) {(data , response,error) in
                if error != nil {
                    self.delegate?.updateFailWeather(error!)
//                    print(error!)
                    return
                }
                if let safeData = data {
//                    print json data in string
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString)
                    
//                 special thing about closure when we call function we must use self.
                    if  let weather = self.parseJson(weatherData : safeData){
                        print(weather)
                        self.delegate?.didUpdateWeather(weather : weather)
                    }
                    
                }
            }

        // 4 . start a task
            task.resume()
        }
    }
    
    
    func parseJson(weatherData : Data) -> WeatherModel? {
        let decode = JSONDecoder()
        
        do{
            let decodeData=try decode.decode(WeatherData.self, from: weatherData)
//            print(decodeData)
            let id = decodeData.weather[0].id
            let name = decodeData.name
            let temp = decodeData.main.temp
            let description = decodeData.weather[0].description
            
            let weather=WeatherModel(conditionId: id, cityName: name, temprature: temp, description: description)
//            print(weather.conditionName , weather.tempratureAccurate)
            
            return weather
            
        }catch{
            self.delegate?.updateFailWeather(error)
//            print(error)
            return nil
        }
    }
    
}






//Fetching API
//// 1 . Create url
//
//      if let url = URL(string: urlString) {
//
//      // 2 . Create a URL session
//          let session=URLSession(configuration: .default)
//
//      // 3 . Give the session a task
//          let task = session.dataTask(with: url, completionHandler: handler(data: urlResponse: error:))
//
//      // 4 . start a task
//          task.resume()
//      }
//  }
//
//  func handler(data: Data? , urlResponse:URLResponse? , error:Error?){
//      if error != nil {
//          print(error!)
//          return
//      }
//
//      if let safeData = data {
//          let dataString = String(data: safeData, encoding: .utf8)
//          print(dataString)
//      }
//
