//
//  ForecastCell.swift
//  SnowMan
//
//  Created by Bhagat Singh on 12/21/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    /*
    * Information about all the variables and methods used                        *
    Variables
    * dayLabel   = The label which displays the day                               *
    * imageLabel = The label which displays the image                             *
    * tempLabel  = The label which displays the temprature                        *
    
    Methods
    * configureCell = The method which sets up the UI for the cell                *
    * extractCode   = The method which rounds off the weather code from the api   *
    */
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configureCell(forecast : Forecast){
        dayLabel.text = forecast.date
        imageLabel.image = UIImage(named:extractCode(code: forecast.weatherCode))
        tempLabel.text = "\(Int(forecast.highTemp))°/\(Int(forecast.lowTemp))"
    }
    
    func extractCode(code: Int) -> String{
        switch code{
        case 200..<260 : return "Thunderstorm"
        case 300..<340 : return "Drizzle"
        case 500..<540 : return "Rain"
        case 600..<640 : return "Snow"
        case 700..<790 : return "Atmosphere"
        case 800..<800 : return "Clear"
        case 801..<810 : return "Clouds"
        case 900..<903 : return "Tornado"
        case 903 : return "Snow"
        case 904 : return "Clear"
        case 905 : return "Windy"
        case 903 : return "Hail"
        case 951..<960 : return "Windy"
        case 960..<965 : return "Tornado"
        default: return "Atmosphere"
        }
    }
}
