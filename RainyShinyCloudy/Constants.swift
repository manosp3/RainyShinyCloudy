//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by Emmanouil Perakis on 22/07/2017.
//  Copyright © 2017 Emmanouil Perakis. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGTITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "b0ed267866b6ecdd5bc85e03a59019c1"

//this is going to tell our func when download is completed
typealias DownloadComplete = () -> ()

//Allagi sto info.plist gia na epitrepi site pou den einai https!!!
let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=b0ed267866b6ecdd5bc85e03a59019c1"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&appid=b0ed267866b6ecdd5bc85e03a59019c1"



