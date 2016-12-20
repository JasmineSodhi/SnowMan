//
//  CurrentWeather.swift
//  SnowMan
//
//  Created by Bhagat Singh on 12/21/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import Foundation
import UIKit

class CurrentWeather{
    var _cityName : String!
    var _date : String!
    var _weatherType : String!
    var _currentTemprature : String!
    var _humidity : String!
    var _windType : String!
    
    
    //MARK:- Getters and initializers
    var cityName : String{
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var date : String{
        if _date == nil{
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = currentDate
        return _date
    }
    
    var weatherType : String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemprature : String{
        if _currentTemprature == nil{
            _currentTemprature = ""
        }
        return _currentTemprature
    }
    
    var humidity : String{
        if _humidity == nil{
            _humidity = ""
        }
        return _humidity
    }
    
    var windType : String{
        if _windType == nil{
            _windType = ""
        }
        return _windType
    }
    
    
    
    
    
    
}
