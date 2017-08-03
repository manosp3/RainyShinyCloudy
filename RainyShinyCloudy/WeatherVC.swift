//
//  WeatherVC.swift
//  RainyShinyCloudy
//
//  Created by Emmanouil Perakis on 20/07/2017.
//  Copyright © 2017 Emmanouil Perakis. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire


class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var CurrentTempLbl: UILabel!
    
    @IBOutlet weak var LocationLbl: UILabel!
    
    @IBOutlet weak var WeatherImg: UIImageView!
    
    @IBOutlet weak var CurrentWeatherLbl: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to self to vazo giati i metavliti locationManager einai se afto to VC
        //anagkastika gia otan vazo location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        myTableView.delegate = self
        myTableView.dataSource = self
    
        //we instanciate an empty forecast class to be able to use it
        // forecast = Forecast()
        currentWeather = CurrentWeather()
    
    }
    //AFTO TO KANO GIATI TREXI PRIN TO VIEWDIDLOAD ara mas simferei
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            locationAuthStatus()
    }
    
    func locationAuthStatus() {
        //if we are authorized to get the location , we acces it and save it in currentLocation var
        //MIN ksexaso - allagi sto info.plist gia to pop up minima me ton kairo
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            //prepei prota na exoume katevasei ta dedomena gia na to valoume stis var, giafto de mpenei to parakato sto viewdidload

            currentWeather.downloadWeatherDetails {
                //Setup UI to Download data
                self.downloadForecastData{
                    self.updateMainUI()
                }
            }
        } else {
            //otan den tou exoume ksanaepitrepsi sto parelthon na kanei srisi tis topothesias mas.
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
        
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //download our forecast data for our tableview
        //let forecast_url = URL(string: FORECAST_URL)!
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    
                    for obj in list {
                        
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                        
                    }
                    //etsi kanoume remove to proto index giati mas evgaze ti mera pou imaste sta cell
                    self.forecasts.remove(at: 0)
                    //etsi kanoume refresh ta cell mas gia na gemisoun me data
                    self.myTableView.reloadData()

                }
            }
            completed()
        
        }
        
//        completed()
    }
    
    
    
    //SOS functions gia ta tableviews
    //POSA sections tha exei to tableview mas
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        // return 1 leei oti thelume 1 section
    }


    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        // afto ftiaxnei anagnorizei pio cell tha anadrimiourgi se olo to tableview
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            let theForecast = forecasts[indexPath.row]
            cell.configureCell(forecast: theForecast)
            return cell
        }else {
            return WeatherCell()
        }
        
        
        //return cell
    }
   
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//    
 
  
    
    
    // posa cell/grammes thes na exei to tableview sou
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
        // thelo 6 cells
    }
    
    func updateMainUI() {
    
        dateLbl.text = currentWeather.date
        CurrentTempLbl.text = "\(currentWeather.currentTemp) °C"
        CurrentWeatherLbl.text = currentWeather.weatherType
        LocationLbl.text = currentWeather.cityName
//        WeatherImg.image = UIImage(named: theCurrentWeather.weatherType)
       WeatherImg.image = UIImage(named: currentWeather.weatherType)
    
    }
 
    
}

