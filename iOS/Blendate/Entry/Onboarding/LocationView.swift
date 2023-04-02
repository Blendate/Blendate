//
//  LocationView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import CoreLocationUI
import SwiftUI
import MapKit

#warning("Fix Published Main Thread")
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
                MapAnnotation(coordinate: location.coordinate) {
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
//    var distanceCirlce: some View {
//        let kilometerSize = (geo.size.height/region.spanLatitude.converted(to: .kilometers).value)
//        Circle()
//            .strokeBorder(Color.white, lineWidth: 2)
//            .background(Circle().fill(Color.Blue.opacity(0.5)))
//            .frame(width: CGFloat(maxDistance * 10), height: CGFloat(maxDistance * 10))
//    }
}

#if DEBUG
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(location: .constant(alice.details.location), maxDistance: .constant(50))
    }
}
#endif


