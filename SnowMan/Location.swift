//
//  Location.swift
//  SnowMan
//
//  Created by Bhagat Singh on 12/21/16.
//  Copyright © 2016 com.bhagat_singh. All rights reserved.
//

import Foundation
import UIKit

class Location{
    static var sharedInstance = Location()
    private init() {}
    
    var latitude : Double!
    var longitude : Double!
}
