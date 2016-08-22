//
//  MyAnnotation.swift
//  Smartdine_Delivery
//
//  Created by Rakesh on 03/02/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MyAnnotation: NSObject,MKAnnotation {
    
    var title : String?
    var subTit : String?
    var coordinate : CLLocationCoordinate2D
    
    init(title:String,coordinate : CLLocationCoordinate2D,subtitle:String){
        
        self.title = title;
        self.coordinate = coordinate;
        self.subTit = subtitle;
        
    }
    
}