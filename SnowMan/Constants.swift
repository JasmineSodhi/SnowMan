//
//  Constants.swift
//  SnowMan
//
//  Created by Bhagat Singh on 12/21/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import Foundation
import UIKit
let current_base_url = "http://api.openweathermap.org/data/2.5/weather?"
let daily_base_url = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let latitude = "lat="
let longitude = "&lon="
let app_id = "&appid="
let api_key = "YOUR-API-KEY-HERE"


typealias completed = () -> ()

let currentWeatherUrl = "\(current_base_url)\(latitude)\(Location.sharedInstance.latitude!)\(longitude)\(Location.sharedInstance.longitude!)\(app_id)\(api_key)"


let forecastWeatherUrl = "\(daily_base_url)\(latitude)\(Location.sharedInstance.latitude!)\(longitude)\(Location.sharedInstance.longitude!)&cnt=10&mode=json\(app_id)\(api_key)"


