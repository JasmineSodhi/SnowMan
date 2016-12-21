//
//  ForecastCell.swift
//  SnowMan
//
//  Created by Bhagat Singh on 12/21/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configureCell(forecast : Forecast){
        dayLabel.text = forecast.date
        imageLabel.image = UIImage(named:"\(forecast.weatherType)")
        tempLabel.text = "\(forecast.highTemp)°/\(forecast.lowTemp)"
    }
}
