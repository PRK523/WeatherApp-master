//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by PRANOTI KULKARNI on 5/24/19.
//  Copyright © 2019 PRANOTI KULKARNI. All rights reserved.
//

import UIKit

class WeatherModel {

    //Declare your model variables here
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    
        case 0...300 :
            return "thunderstorm"
        
        case 301...500 :
            return "rain"
        
        case 501...600 :
            return "snow"
        
        case 601...700 :
            return "snow"
        
        case 701...771 :
            return "fog"
        
        case 772...799 :
            return "windy"
        
        case 800 :
            return "sunny"
        
        case 801...804 :
            //use of partly-cloudy image url provided in the project requirements.
            let url = URL(string: "http://openweathermap.org/img/w/10d.png")!
            return String(describing: url)
        
        case 900...903, 905...1000  :
            return "thunderstorm"
        
        case 903 :
            return "snow"
        
        case 904 :
            return "sunny"
        
        default :
            return " "
        }

    }
}
