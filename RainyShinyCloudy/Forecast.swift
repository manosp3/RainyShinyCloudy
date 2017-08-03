//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by Emmanouil Perakis on 25/07/2017.
//  Copyright © 2017 Emmanouil Perakis. All rights reserved.
//

import Foundation
import Alamofire

class Forecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: Int!
    private var _lowTemp: Int!

    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weathertype: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: Int {
        if _highTemp == nil {
            _highTemp = 0
        }
        return _highTemp
    }
    
    var lowTemp: Int {
        if _lowTemp == nil {
            _lowTemp = 0
        }
        return _lowTemp
    }
    

    init(weatherDict: Dictionary <String, Any>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, Any>{
            if let min = temp["min"] as? Int {
                
                let kelvinToCelsius = min - 273
                self._lowTemp = kelvinToCelsius

            }
            
            if let max = temp["max"] as? Int {
                let kelvinToCelsiusMax = max - 273
                self._highTemp = kelvinToCelsiusMax
            }
        }
        ////////////////////// allages edo......
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let mydate = weatherDict["dt"] as? Int {
            let dateFormatter = DateFormatter()
            let unixConvertedDate = Date(timeIntervalSince1970: TimeInterval(mydate))
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
    
}


extension Date {
    
    func dayOfTheWeek() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}


