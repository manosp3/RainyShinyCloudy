//
//  CurrentWeather.swift
//  RainyShinyCloudy
//
//  Created by Emmanouil Perakis on 22/07/2017.
//  Copyright © 2017 Emmanouil Perakis. All rights reserved.
//

import UIKit
import Alamofire


class CurrentWeather {

   private var _cityName: String!
   private var _date: String!
   private var _weatherType: String!
   private var _currentTemp: Int!

    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        //formation of the dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Int {
        if _currentTemp == nil {
            _currentTemp = 0
        }
        return _currentTemp
    }
 
    //AFTO THELEI NA PAEI STO CONTROLLER MALLON
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Download current weather
        //Alamofire download
        //let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
            
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    //Only for ARRAY of dictionaries this syntax
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        //OTAN EIMASTE MESA SE {} KANOUME PRINT ME TO PRINT(self.something)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any> {
                    
                    if let currentTemperature = main["temp"] as? Int {
                    
                        let kelvinToCelsius = currentTemperature - 273
                        self._currentTemp = kelvinToCelsius
                    }
                    
                }
            
            }
            
            completed()

        }
        
    }
    
    
//    init(cityname: String, date: String, weathertype: String, currenttemp: Double) {
//        self._cityName = cityname
//        self._date = date
//        self._weatherType = weathertype
//        self._currentTemp = currenttemp
//    }
    
}
