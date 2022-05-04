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
    
    
    @State var maxDistance: Int = 1
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: -73), span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))
    var distanceProxy: Binding<Double>{
        Binding<Double>(get: {
            return Double(maxDistance)
        }, set: {
            maxDistance = Int($0)
        })
    }
    
    var body: some View {
        VStack{
            SignupTitle(.location)
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
                                .frame(width: CGFloat(maxDistance * 10), height: CGFloat(maxDistance * 10))
                        }
                    }
                }
//                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .cornerRadius(12)
                    .padding(.bottom)
                if viewModel.location.name.isEmpty {
                    LocationButton(.currentLocation) {
                        viewModel.isLoading = true
                        viewModel.requestAllowOnce()
                    }
                    .cornerRadius(8)
                    .labelStyle(.titleAndIcon)
                    .symbolVariant(.fill)
                    .tint(.Blue)
                    .padding(.bottom, 50)
                    .foregroundColor(.white)
                    .disabled(viewModel.isLoading)
                } else {
                    
                }
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        VStack {
                            ProgressView()
                                .padding()
                        }.background(Color.white)
                            .cornerRadius(16)
                        Spacer()
                    }
                }

            }
            .padding(.horizontal)
        }
        .onChange(of: viewModel.location) { newValue in
            location = newValue
        }
    }
    
    var slider: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("\(maxDistance) mi")
                    .foregroundColor(.DarkBlue)
            }
            Slider(value: distanceProxy, in: 1...50)
                .tint(.Blue)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.bottom, 50)
        .padding(.horizontal, 30)
    }
}


class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: -73), span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))
    @Published var location: Location = Location(name: "", lat: 40, lon: -73)
    @Published var isLoading = false


    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func requestAllowOnce() {
        locationManager.requestLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {return}
        locationGeo(location: latestLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error")
        printD(error.localizedDescription)
    }
    
    func locationGeo(location: CLLocation) {
        Task {
            let placemarks = try await CLGeocoder().reverseGeocodeLocation(location) //.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let _ = placemark.location?.coordinate.longitude ?? 0.0
                let _ = placemark.location?.coordinate.latitude ?? 0.0
                let name = placemark.subAdministrativeArea!
                let _ = placemark.country!
                let region = placemark.administrativeArea!
                
                let title = name + ", " + region
                DispatchQueue.main.async {
                    self.location = Location(name: title, lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                    self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                    self.isLoading = false
                }

            }
        }
        

    }
}

#if DEBUG
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
//        PreviewSignup(.location)
        ZStack {
            Color.Blue
            LocationView(location: .constant(Location(name: "", lat: 40, lon: -73))).slider.previewLayout(.sizeThatFits)

        }
        
    }
}
#endif

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return (lhs.center.latitude == rhs.center.latitude) && (lhs.center.longitude == rhs.center.longitude)
    }
    
    
}

