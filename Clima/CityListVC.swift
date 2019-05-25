//
//  CityListVC.swift
//  WeatherApp
//
//  Created by PRANOTI KULKARNI on 5/25/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//


import UIKit

//Write the protocol declaration here:
protocol ChangeCityDelegate {
    func newCityName(city: String)
}


class CityListVC: UIViewController {
    
    //Declaring the delegate:
    var delegate : ChangeCityDelegate?
    
    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        
        
        //1. Get the city name when UIButton is clicked
        let city = sender as? UIButton
        
        if city?.titleLabel!.text == "LONDON" {
            delegate?.newCityName(city: "LONDON")
        }
        else if city?.titleLabel!.text == "TOKYO" {
            delegate?.newCityName(city: "TOKYO")
        }
        
        //2. dismiss the Change City View Controller to go back to the WeatherViewController
        self.dismiss(animated: true, completion: nil)
        
    }
    
    

    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

