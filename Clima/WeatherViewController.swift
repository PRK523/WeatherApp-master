//
//  ViewController.swift
//  WeatherApp
//
//  Created by PRANOTI KULKARNI on 5/24/19.
//  Copyright © 2019 PRANOTI KULKARNI. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
   
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "a4469b8e7f3aa3d962147a8c4b0ff185"
    

    let locationManager = CLLocationManager()
    let weatherModel = WeatherModel()

    
    @IBOutlet var backroundView: UIView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var changeCityButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backroundView.backgroundColor = UIColor.cyan
        changeCityButton.layer.borderWidth = 1.0
        changeCityButton.layer.cornerRadius = 1
        changeCityButton.layer.borderColor = UIColor.white.cgColor
        changeCityButton.layer.backgroundColor = nil
        
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //getWeatherData method here:
    func getWeatherData(url: String, parameters: [String : String]){
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON() {
            response in
            if response.result.isSuccess {
                print("Sucess")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            }
            
            if response.result.isFailure{
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //updateWeatherData method here:
    func updateWeatherData(json : JSON) {
        
        if let tempResult = json["main"]["temp"].double {
        
        let celsius = Double(tempResult - 273.5)
        let fahrenheit = Double(celsius * 1.8) + 32
        weatherModel.temperature = Int(Double(fahrenheit))
        
        weatherModel.city = json["name"].stringValue
        
        weatherModel.condition = json["weather"][0]["id"].intValue
        
        weatherModel.weatherIconName = weatherModel.updateWeatherIcon(condition: weatherModel.condition)
        
        updateUIWithWeatherData()
        
        
        }
        else {
            cityLabel.text = "Weather Unavailable"
        }
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //updateUIWithWeatherData method here:
    func updateUIWithWeatherData() {
        
        cityLabel.text = weatherModel.city
        temperatureLabel.text = "\(weatherModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherModel.weatherIconName)
        
        
        
    }
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //didUpdateLocations method here:
    // CLLocaiton array stores location data in an every increasing order
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        // Accruate locaitons cant be negitive
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("longtiude = \(location.coordinate.longitude) and latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon": longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    //didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }
    
    

    
    //CityList Delegate methods
    /***************************************************************/
    
    
    //cityName Delegate method here:
    func newCityName(city: String) {
        
        let params : [String : String] = ["q" : city, "appid": APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
        
    }
    
    
    //PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            
            let destinationVC = segue.destination as! CityListVC
            
            destinationVC.delegate = self
        }
    }
    
}


