//
//  WeatherVC.swift
//  SnowMan
//
//  Created by Bhagat Singh on 12/21/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var mainThumb: UIImageView!
    @IBOutlet weak var mainType: UILabel!
    @IBOutlet weak var mainCity: UILabel!
    @IBOutlet weak var mainTemp: UILabel!
    @IBOutlet weak var highLow: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    
    var currentWeather : CurrentWeather!
    var forecasts = [Forecast]()
    
    let paragraphStyle = NSMutableParagraphStyle()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        currentWeather = CurrentWeather()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping completed){
        Alamofire.request(forecastWeatherUrl, method: .get).responseJSON { (response) in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]{
                    for obj in list{
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.collectionView.reloadData()
                }
            }
            completed()
        }
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
            default : return "Atmosphere"
        }
    }
    
    func updateMainUI(){
    
        mainThumb.image = UIImage(named:extractCode(code:currentWeather.weatherCode))
        mainType.addCharactersSpacing(spacing: 6, text: currentWeather.weatherType.uppercased())
        mainCity.addCharactersSpacing(spacing: 4, text: "\(currentWeather.cityName), \(currentWeather.countryCode)")
        mainTemp.text = "\(currentWeather.currentTemprature)"
        highLow.text = "\(Int(currentWeather.min))°/\(Int(currentWeather.max))°"
        windSpeed.text = "\(currentWeather.windType)m/s"
        humidity.text = "\(currentWeather.humidity)"
    }
    
    //MARK:- Collection View Delegate and Data Source Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as? ForecastCell{
            let fore = forecasts[indexPath.row]
            cell.configureCell(forecast: fore)
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 76.0, height: 112.0)
    }
    
}

extension UILabel {
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
        self.attributedText = attributedString
    }
}
