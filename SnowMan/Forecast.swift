//
//  Forecast.swift
//  SnowMan
//
//  Created by Bhagat Singh on 12/21/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class Forecast{
    
    var _date: String!
    var _highTemp: Double!
    var _lowTemp: Double!
    var _weatherType : String!
    var _weatherCode : Int!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return _highTemp
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    var weatherType : String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var weatherCode : Int{
        if _weatherCode == nil{
            _weatherCode = 0
        }
        return _weatherCode
    }
    
    func kelvinToCelcius(temprature: Double) -> Double{
        let newTemp = Double(round(temprature - 273.15))
        return newTemp
    }
    
    init(weatherDict: Dictionary<String,AnyObject>){
        
        if let temp = weatherDict["temp"] as? Dictionary<String,AnyObject>{
            if let min = temp["min"] as? Double{
                self._lowTemp = kelvinToCelcius(temprature: min)
            }
            if let max = temp["max"] as? Double{
                self._highTemp = kelvinToCelcius(temprature: max)
            }
        }
        if let date = weatherDict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            let temp = unixConvertedDate.dayOfTheWeek()
            let index = temp.index(temp.startIndex, offsetBy: 3)
            self._date = temp.substring(to: index).capitalized
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String,AnyObject>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
            
            if let id = weather[0]["id"] as? Int{
                self._weatherCode = id
            }
        }
    }
}


extension Date{
    func dayOfTheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
