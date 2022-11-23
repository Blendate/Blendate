//
//  LocationView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import CoreLocationUI
import SwiftUI
import MapKit

struct LocationView: View {
    @Binding var location: Location
    @Binding var maxDistance: Int
    var isFilter = false

    @StateObject private var viewModel = LocationModel()
    
    
    var body: some View {
        VStack{
            SignupTitle(.location)
            header
            ZStack(alignment: .bottom) {
                map
                slider
            }
        }
        .onChange(of: viewModel.location) { newValue in
            location = newValue
        }
    }
    
    var header: some View {
        VStack {
            Text("Only neighborhood name will be shown")
                .fontType(.regular, 18, .DarkBlue.opacity(0.65))
                .multilineTextAlignment(.center)
                .frame(width: 250, alignment: .center)
            Text(viewModel.location.name)
                .fontType(.semibold, 20, .DarkBlue)
                .padding(.top, 5)
        }
    }
    
    var map: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: [viewModel.location]) { location in
            MapAnnotation(coordinate: location.coordinate) {
                distanceCirlce
            }
            
        }
        .padding()
        .cornerRadius(12)
        .onAppear {
            viewModel.checkService()
        }
    }
    
    var distanceProxy: Binding<Double>{
        Binding<Double>(
            get: { return Double(maxDistance)},
            set: { maxDistance = Int($0) })
    }
    
    var slider: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Max Distance")
                Spacer()
                Text("\(maxDistance) mi")
            }
            .foregroundColor(.DarkBlue)
            Slider(value: distanceProxy, in: 1...50)
                .tint(.Blue)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.bottom, 50)
        .padding(.horizontal, 30)
    }
    
    var distanceCirlce: some View {
        Circle()
            .strokeBorder(Color.white, lineWidth: 2)
            .background(Circle().fill(Color.Blue.opacity(0.5)))
            .frame(width: CGFloat(maxDistance * 10), height: CGFloat(maxDistance * 10))
    }
}

#if DEBUG
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.location)
//            .environmentObject(dev.session)
    }
}
#endif


enum MapDetails {
    static let startLocation = CLLocationCoordinate2D(latitude: 40, longitude: -73)
    static let startSpan = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
    static let locationSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}
class LocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion(
        center: MapDetails.startLocation,
        span: MapDetails.startSpan)
    
    @Published var location: Location = Location(name: "", lat: 0, lon: 0)
    
    func checkService(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        } else {
            print("Location Service Disabled")
        }
    }
    
    private func checkAuthorization() {
        guard let locationManager = locationManager else {return}
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location Restricted")
        case .denied:
            print("Location Denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MapDetails.locationSpan)
            try? geoLocation(locationManager.location!)
            
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
    private func geoLocation(_ location: CLLocation) throws {
        Task { @MainActor in
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
