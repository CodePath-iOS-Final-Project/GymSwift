//
//  MapViewController.swift
//  GymSwift
//
//  Created by Philip Park on 11/22/21.
//

import CoreLocation
import CoreLocationUI
import MapKit
import UIKit


class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let manager =  CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
        private func createLocationButton() {
            let locationButton = CLLocationButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            locationButton.center = CGPoint(x: view.center.x, y: view.frame.size.height-110)
            locationButton.label = .currentLocation
            locationButton.icon = .arrowFilled
            locationButton.cornerRadius = 25.0
            locationButton.layer.shadowOpacity = 0.25
            locationButton.alpha = 0.78
            view.addSubview(locationButton)
            locationButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
    
        @objc func didTapButton() {
            manager.startUpdatingLocation()
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location:  CLLocation ){
        let coordinate =  CLLocationCoordinate2D(latitude: 40.7366,
                                                 longitude: -73.8201)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate,
                                        span: span)
        mapView.setRegion(region,
                          animated: true)
        nearbyParks()
    }
    
    func nearbyParks() {
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: 40.7366,
                                            longitude: -73.8201)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "parks"
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { ( response, error ) in
            guard let response = response else {
            return
        }

        for item in response.mapItems {
            let pins = MKPointAnnotation()
            pins.coordinate = item.placemark.coordinate
            pins.title = item.name

            DispatchQueue.main.async{
                self.mapView.addAnnotation(pins)
                }
            }
        }
    }
}

