//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController , UITextFieldDelegate,WeatherManagerDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
//    to initialize weather manager class and delegate also set below
    var myWeather=WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this is usedto call the search field text on press go enter in keyborad
        searchTextField.delegate = self
            
        // to set weather delegate
        myWeather.delegate=self
        
    }
    
//    this is called when serach icon is pressed
    @IBAction func searchPressed(_ sender: UIButton) {
        // this is called when editing is end
        searchTextField.endEditing(true)
    }
    
//     this is called when you press return on keyboard it is inbuilt function called by delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    
//    this is called when you nedd validation at some point in input and you want to stop it by
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != ""){
            return true
        }
        else{
        textField.placeholder = "Type something"
            return false
        }
    }
    
//    this is called when you user has input and serch so to clen input field
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            
        //so before reset text we should know its value
        if let city = searchTextField.text {
            myWeather.fetchweather(cityName: city)
        }
        
        // this used to reset text field
        searchTextField.text=""
        
    }
    
    
    func didUpdateWeather(weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.tempratureAccurate
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        
        print("so in viewc ",weather)
    }
    
    func updateFailWeather(_ error: Error) {
        print("There is problem in connection")
    }
    


}

