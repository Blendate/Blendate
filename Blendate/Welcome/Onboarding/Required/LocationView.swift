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
    @StateObject private var viewModel = LocationViewModel()
    
    @State var maxDistance: Int = 0
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: -73), span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))
    var distanceProxy: Binding<Double>{
        Binding<Double>(get: {
            return Double(maxDistance * 10)
        }, set: {
            maxDistance = Int($0 / 10)
        })
    }
    
    var body: some View {
        VStack{
            VStack {
                Text("Only neighborhood name will be shown")
                    .fontType(.regular, 18, .DarkBlue.opacity(0.65))
                    .multilineTextAlignment(.center)
                    .frame(width: 250, alignment: .center)
                Text(viewModel.location.name)
                    .fontType(.semibold, 20, .DarkBlue)
                    .padding(.top, 5)
            }
            
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $viewModel.region, annotationItems: [viewModel.location]) { location in
                    MapAnnotation(coordinate: location.coordinate()) {
                        if !viewModel.location.name.isEmpty {
                            Circle()
                                .strokeBorder(Color.white, lineWidth: 2)
                                .background(Circle().fill(Color.Blue.opacity(0.5)))
                                .frame(width: CGFloat(maxDistance), height: CGFloat(maxDistance))
                        }
                    }
                }
//                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .cornerRadius(12)
                    .padding(.bottom)
                if viewModel.location.name.isEmpty {
                    LocationButton(.currentLocation) {
                        viewModel.requestAllowOnce()
                    }
                    .cornerRadius(8)
                    .labelStyle(.titleAndIcon)
                    .symbolVariant(.fill)
                    .tint(.Blue)
                    .padding(.bottom, 50)
                    .foregroundColor(.white)
                } else {
                    Slider(value: distanceProxy, in: 50...500)
                        .padding()
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding(.bottom, 50)
                        .padding(.horizontal, 30)
                        .tint(.Blue)
                }

            }
            .padding(.horizontal)
        }
        .onChange(of: viewModel.location) { newValue in
            location = newValue
        }
//        .onChange(of: maxDistance) { newValue in
//            user.filters.maxDistance = newValue
//        }

    }
}


class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: -73), span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))
    @Published var location: Location = Location(name: "", lat: 40, lon: -73)
    

    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowOnce() {
        locationManager.requestLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {return}
        Task {
            try await locationGeo(location: latestLocation)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error")
        printD(error.localizedDescription)
    }
    
    
    func locationGeo(location: CLLocation) async throws {
        let placemarks = try await CLGeocoder().reverseGeocodeLocation(location) //.reverseGeocodeLocation(location)
        if let placemark = placemarks.first {
            let _ = placemark.location?.coordinate.longitude ?? 0.0
            let _ = placemark.location?.coordinate.latitude ?? 0.0
            let name = placemark.subAdministrativeArea!
            let _ = placemark.country!
            let region = placemark.administrativeArea!
            
            let title = name + ", " + region
            
            self.location = Location(name: title, lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

        }
    }
    
//    func locationGeo(location: CLLocation, completion: @escaping (String) -> Void) {
//        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
//            guard error == nil else {
//                print("Location Error")
//                printD(error!.localizedDescription)
//                return
//            }
//            if let placemark = placemarks?[0]{
//                let _ = placemark.location?.coordinate.longitude ?? 0.0
//                let _ = placemark.location?.coordinate.latitude ?? 0.0
//                let name = placemark.subAdministrativeArea!
//                let _ = placemark.country!
//                let region = placemark.administrativeArea!
//
//                let string = name + ", " + region
//
//                completion(string)
//
//            }
//        }
//    }

}

//extension Map {
//    func addOverlay(_ overlay: MKOverlay) -> some View {
//        MKMapView.appearance().addOverlay(overlay)
//        return self
//    }
//}

#if DEBUG
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.location)
    }
}
#endif

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return (lhs.center.latitude == rhs.center.latitude) && (lhs.center.longitude == rhs.center.longitude)
    }
    
    
}

