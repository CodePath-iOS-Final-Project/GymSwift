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
        
        createLocationButton()
       
    }
    
        private func createLocationButton() {
            let locationButton = CLLocationButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            locationButton.center = CGPoint(x: view.center.x, y: view.frame.size.height-110)
            locationButton.label = .currentLocation
            locationButton.icon = .arrowOutline
            locationButton.cornerRadius = 25.0
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
        
        let coordinate =  CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                 longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate,
                                        span: span)
        mapView.setRegion(region,
                          animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}

