//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Emmanouil Perakis on 26/07/2017.
//  Copyright © 2017 Emmanouil Perakis. All rights reserved.
//

import CoreLocation

// AFTI EINAI MIA SINGLETON CLASS!!

class Location {
    //static var einai sa min global var pou mpori olo to project na tin elenksei
    static var sharedInstance = Location()
    private init () {}
    
    var latitude: Double!
    var longitude: Double!
}
