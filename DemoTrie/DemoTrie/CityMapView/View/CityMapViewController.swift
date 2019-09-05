//
//  CityMapViewController.swift
//  DemoTrie
//
//  Created by Gaurav Tiwari on 21/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit
import MapKit

class CityMapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var city : City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "City Map"
        mapView.delegate = self
        
        if (city != nil){
            showCity(city: city!)
        }
    }
    
    func showCity(city: City){
        let pin = CityAnnotation()
        
        let lat = city.cityCoordinates.latitude
        let long = city.cityCoordinates.longitude
        
        let latitude : CLLocationDegrees = lat
        let longitude : CLLocationDegrees = long

        let center = CLLocationCoordinate2D (latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion (center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        pin.coordinate = center
        pin.cityDetail = city
        mapView.addAnnotation(pin)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as? CityAnnotation
        print(annotation?.cityDetail?.cityName as Any)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
