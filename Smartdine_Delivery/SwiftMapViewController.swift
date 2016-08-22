//
//  SwiftMapViewController.swift
//  Smartdine_Delivery
//
//  Created by Rakesh on 03/02/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit

import MapKit
import CoreLocation

class SwiftMapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        
//        
//        let latDir = NSUserDefaults .standardUserDefaults().stringForKey(klat)
//        print("latitude:\(klat)")
//        
//        let longDir = NSUserDefaults .standardUserDefaults().stringForKey(klong)
//        print("longitude:\(klong)")
        
        
//        let latitude = NSUserDefaults .standardUserDefaults().valueForKey(klat) as! Double
//        
//         let longitude = NSUserDefaults .standardUserDefaults().valueForKey(klong) as! Double
//        let latitude = Double(NSUserDefaults .standardUserDefaults().valueForKey(klat) as! String ?? "0.0")
//        
//        let longitude = Double(NSUserDefaults .standardUserDefaults().valueForKey(klong) as! String ?? "0.0")
       
        
        
        let latitude = NSUserDefaults .standardUserDefaults().doubleForKey(klat)
        let longitude = NSUserDefaults .standardUserDefaults().doubleForKey(klong)
        
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        //Second Location lat and long
        let latitudeSec:CLLocationDegrees = 10.0100
        
        let longitudeSec:CLLocationDegrees = 76.3620
        
        let locationSec:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudeSec, longitudeSec)
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(1, 1)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
      
        
        
        
        let myAn1 = MyAnnotation(title: "Office", coordinate: location,subtitle: "MyOffice");
        
        
        
        let myAn2 = MyAnnotation(title: "Office 1", coordinate: locationSec,subtitle: "MyOffice1");
        
        mapView.addAnnotation(myAn1);
        mapView.addAnnotation(myAn2);
        
//        let cPolyline = CustomPolyline(coordinates: location, count: location.count)
//        cPolyline.color = "#ff0000"
//        self.mapView.addOverlay(cPolyline)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    func mapView(mapView: MKMapView!, rendererForOverlay overlay: CustomPolyline!) -> MKOverlayRenderer! {
//        
//        var pr = MKPolylineRenderer(overlay: overlay);
//        pr.strokeColor = UIColor.redColor()
//        pr.lineWidth = 10;
//        return pr;
//        
//    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        print("Locations = \(locations)")
        
        let userLocation: CLLocation = locations[0] as CLLocation
        
        //var latitude:CLLocationDegrees = userLocation.coordinate
        //var longitude:CLLocationDegrees = -121.934048
        //var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(userLocation.coordinate, span)
        
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
        
        
    }
    
    func action(gesture: UILongPressGestureRecognizer) {
        let touchPoint = gesture.locationInView(self.mapView)
        let location:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        let newAnnot:MKPointAnnotation = MKPointAnnotation()
        newAnnot.coordinate = location
        newAnnot.title = "My New annotation"
        newAnnot.subtitle = "My New annotation sub title"
        self.mapView.addAnnotation(newAnnot)
        
    }
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
