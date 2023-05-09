//
//  LocationManager.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/23/23.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion(
        center: MapDetails.startLocation,
        span: MapDetails.startSpan)
    
    @Published var location: Location = Location(name: "", lat: 0, lon: 0)
    
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.delegate = self
    }
    

    
    @MainActor
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location Restricted")
        case .denied:
            print("Location Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = manager.location {
                try? geoLocation(location)
            }
            
        @unknown default:
            break
        }
    }
    
    private func geoLocation(_ location: CLLocation) throws {
        Task { @MainActor in
            
            self.region = MKCoordinateRegion(center: location.coordinate,
                                        span: MapDetails.startSpan)
            
            let lat:Double = location.coordinate.latitude
            let lon:Double = location.coordinate.longitude
            
            let placemarks = try await CLGeocoder().reverseGeocodeLocation(location)
            guard let placemark = placemarks.first else {return}
            
            let name = placemark.subAdministrativeArea!
            let region = placemark.administrativeArea!
            let title = name + ", " + region

            self.location = Location(name: title, lat: lat, lon: lon)
        }
    }
}

extension MKCoordinateRegion{
    ///Identify the length of the span in meters north to south
    var spanLatitude: Measurement<UnitLength>{
        let loc1 = CLLocation(latitude: center.latitude - span.latitudeDelta * 0.5, longitude: center.longitude)
        let loc2 = CLLocation(latitude: center.latitude + span.latitudeDelta * 0.5, longitude: center.longitude)
        let metersInLatitude = loc1.distance(from: loc2)
        return Measurement(value: metersInLatitude, unit: UnitLength.meters)
    }
}

enum MapDetails {
    static let startLocation = CLLocationCoordinate2D(latitude: 40, longitude: -73)
    static let startSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    static let locationSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}
