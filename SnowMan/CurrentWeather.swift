//
//  CurrentWeather.swift
//  SnowMan
//
//  Created by Bhagat Singh on 12/21/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CurrentWeather{
    var _cityName : String!
    var _date : String!
    var _weatherType : String!
    var _currentTemprature : Double!
    var _humidity : Double!
    var _windType : Double!
    var _min : Double!
    var _max : Double!
    var _countryCode : String!
    
    
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
    
    var currentTemprature : Double{
        if _currentTemprature == nil{
            _currentTemprature = 0.0
        }
        return _currentTemprature
    }
    
    var humidity : Double{
        if _humidity == nil{
            _humidity = 0.0
        }
        return _humidity
    }
    
    var windType : Double{
        if _windType == nil{
            _windType = 0.0
        }
        return _windType
    }
    
    var min : Double{
        if _min == nil{
            _min = 0.0
        }
        return _min
    }
    
    var max : Double{
        if _max == nil{
            _max = 0.0
        }
        return _max
    }
    
    var countryCode : String{
        if _countryCode == nil{
            _countryCode = ""
        }
        return _countryCode
    }
    
    func kelvinToCelcius(temprature:Double) -> Double{
        let newTemp = Double(round(temprature - 273.15))
        return newTemp
        
    }
    
    func downloadWeatherDetails(completed: @escaping completed){
        
        Alamofire.request(currentWeatherUrl, method: .get).responseJSON { (response) in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                }
                
                if let sys = dict["sys"] as? Dictionary<String,AnyObject>{
                    if let code = sys["country"] as? String{
                        self._countryCode = code
                    }
                }
                
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>]{
                    if let type = weather[0]["main"] as? String{
                        self._weatherType = type.capitalized
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String,AnyObject>{
                    if let temp = main["temp"] as? Double{
                        self._currentTemprature = self.kelvinToCelcius(temprature: temp)
                    }
                    if let minimum = main["temp_min"] as? Double{
                        self._min = self.kelvinToCelcius(temprature: minimum)
                    }
                    if let maximum = main["temp_max"] as? Double{
                        self._max = self.kelvinToCelcius(temprature: maximum)
                    }
                    if let humid = main["humidity"] as? Double{
                        self._humidity = humid
                    }
                }
                
                if let wind = dict["wind"] as? Dictionary<String,AnyObject>{
                    if let speed = wind["speed"] as? Double{
                        self._windType = speed
                    }
                }
            }
        }
        completed()
    }
}
