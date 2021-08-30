//
//  LocationView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    
    @ObservedObject var locationFetcher = LocatonViewModel()
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack{
            VStack {
                Text("My location")
                    .blendFont(32, .DarkBlue)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, alignment: .center)
                Text("Only neighborhood name will be shown")
                    .montserrat(.regular, 16)
                    .foregroundColor(.DarkBlue)
                    .multilineTextAlignment(.center)
                    .frame(width: getRect().width * 0.556, alignment: .center)
            }.padding(.bottom, 50)
            
            VStack {
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.DarkBlue)
                    TextField("Search", text: $locationFetcher.locationString)
                    
                }.padding()
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.Blue, lineWidth: 1.0)
                        .background(Color.white)
                )
                Map(coordinateRegion: $locationFetcher.region, showsUserLocation: true, userTrackingMode: .constant(.follow))
//                    .addOverlay(MKCircle(center: locationFetcher.location!.coordinate, radius: CLLocationDistance(100)))
                    .cornerRadius(12)
                    .padding(.bottom)

                
            }
            .padding()
            
            NavigationLink(
                destination: AboutView(signup),
                isActive: $next,
                label: { EmptyView() }
            )
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: false) {
                                    mode.wrappedValue.dismiss()
                                },
                            trailing:
                                NavNextButton(signup, isTop, save)
        )
        .circleBackground(imageName: nil, isTop: false)
        .onAppear {
            locationFetcher.start()
        }

    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.location = locationFetcher.locationString
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}


class LocatonViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), // London
                                                                   span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    @Published var locationString: String = ""
    
//    @Binding var user: AppUser
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = 100
        
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    
    func geoCode(){
        
        let geoCoder = CLGeocoder()
        
        guard let lat = location?.coordinate.latitude,
              let lon = location?.coordinate.longitude else {return}
        
        let location = CLLocation(latitude: lat, longitude: lon)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error -> Void in

            guard let placeMark = placemarks?.first else { return }

            if let subLocality = placeMark.subLocality,
               let locality = placeMark.locality {
                self.locationString = "\(subLocality), \(locality)"
            }
            
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            self.location = location
            geoCode()
        }
    }
}

extension Map {
    func addOverlay(_ overlay: MKOverlay) -> some View {
        MKMapView.appearance().addOverlay(overlay)
        return self
    }
}

#if DEBUG
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationView(true)
                .environmentObject(AppState())
        }
    }
}
#endif

