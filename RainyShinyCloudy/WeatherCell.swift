//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by Emmanouil Perakis on 26/07/2017.
//  Copyright © 2017 Emmanouil Perakis. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var dayLbl: UILabel!
    
    @IBOutlet weak var weatherLbl: UILabel!
    
    @IBOutlet weak var highLbl: UILabel!
    
    @IBOutlet weak var lowLbl: UILabel!
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

    
    func configureCell(forecast: Forecast) {
        
        lowLbl.text = "\(forecast.lowTemp) °C"
        highLbl.text = "\(forecast.highTemp) °C"
        dayLbl.text = forecast.date
        weatherLbl.text = forecast.weathertype
        //NA THIMASE OTAN THES NA PERASEIS EIKONA TO KANEIS ETSI UIImage(named: ...)
        weatherIcon.image = UIImage(named: forecast.weathertype)
        
    }

}
