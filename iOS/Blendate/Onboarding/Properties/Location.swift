//
//  Location.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import SwiftUI
import CoreLocation
import MapKit
import CoreLocationUI

struct Location: Property {
    init(rawValue: CLLocationCoordinate2D) {
        self.lat = rawValue.latitude
        self.lon = rawValue.longitude
        self.name = "\(self.lat),\(self.lon)"
    }
    
    init(name: String, lat: Double, lon: Double){
        self.name = name
        self.lat = lat
        self.lon = lon
    }
    
    var rawValue: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: lat, longitude: lon) }
    
    var name: String
    let lat: Double
    let lon: Double

    var valueLabel: String { name }
    
    var isValid: Bool { name.isEmpty }
    static let systemImage = "mappin"
    
}

extension Location: Identifiable, Equatable {
    var id: String { "\(lat),\(lon)" }
}

extension Location {
    struct PropertyView: PropertyViewProtocol {
        var value: Binding<Location>
        var isFilter: Bool = false
        @State private var maxDistance: Int = 50
        var body: some View {
            LocationView(location: value, maxDistance: $maxDistance)
        }
    }
    
    struct LocationView: View {
        @Binding var location: Location
        @Binding var maxDistance: Int
        var isFilter = false

        @StateObject private var viewModel = LocationManager()
        
        
        var body: some View {
            VStack{
                Text(viewModel.location.name)
                    .font(.semibold, .DarkBlue)
                    .padding(.top, 5)
                ZStack(alignment: .bottom) {
                    map
                    slider
                }
            }
            .onChange(of: viewModel.location) { newValue in
                location = newValue
            }
        }

        
        var map: some View {
            GeometryReader { geo in
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: [viewModel.location]) { location in
                    MapAnnotation(coordinate: location.rawValue) {
                        distanceCirlce(height: geo.size.height, spanLatitude: viewModel.region.spanLatitude)
    //                    distanceCirlce
                    }
                    
                }
                .padding()
                .cornerRadius(12)
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
        
        @ViewBuilder
        func distanceCirlce(height: CGFloat, spanLatitude: Measurement<UnitLength>) -> some View {
            let kilometerSize = (height/spanLatitude.converted(to: .miles).value) * CGFloat(maxDistance)
            Circle()
                .strokeBorder(Color.white, lineWidth: 2)
                .background(Circle().fill(Color.Blue.opacity(0.5)))
                .frame(width: kilometerSize, height: kilometerSize)

        }
    }
}

extension Location {
    
    struct Cell: View {
        @Binding var distance: Int
        var valueString: String { "\(distance.description) mi" }
        @State var value: Double
        
        init(distance: Binding<Int>) {
            self._distance = distance
            self.value = Double(distance.wrappedValue)
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                PropertyCell(title: "Max Distance", label: valueString, systemImage: Location.systemImage)
                Slider(value: $value, in: 1...50, step: 1.0)
            }
            .onChange(of: value) { newValue in
                distance = Int(newValue)
            }
        }
    }
    
}


struct Location_Previews: PreviewProvider {
    @State static var value = Location(name: "New York", lat: 40.7128, lon: -74.0060)
    static var view: Location.PropertyView { .init(value: $value) }
    
    static var previews: some View {
        view
        PropertyView(Location.self, view: view)
            .previewDisplayName("Property")
    }
}
