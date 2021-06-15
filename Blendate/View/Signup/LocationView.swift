//
//  LocationView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let signup: Bool
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    
    @State var location: String = ""
    
    var body: some View {
            VStack{
                VStack {
                    Text("My location")
                        .blendFont(32, .DarkBlue)
                        .multilineTextAlignment(.center)
                        .frame(width: 300, alignment: .center)
                    Text("Only neighborhood name will be shown")
                        .font(.custom("Montserrat-Regular", size: 16))
                        .foregroundColor(.DarkBlue)
                        .padding(.top,5)
                        .multilineTextAlignment(.center)
                        .frame(width: getRect().width * 0.556, alignment: .center)
                }
                VStack {
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.DarkBlue)
                        TextField("Search", text: $location)
                    }.padding()
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.Blue, lineWidth: 1.0)
                        
                    )
                    Map(coordinateRegion: $region)
                        .cornerRadius(12)
                }
                .padding()
                .frame(width: getRect().width * 0.9, height: getRect().height * 0.65, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.white)
                )
                Spacer()
            }
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: false) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavigationLink(
                                        destination: AboutView(signup, $user),
                                        label: {
                                            NextButton(next: .constant(true), isTop: false)
                                        }
                                    ))
            .circleBackground(imageName: "", isTop: false)
    }
}


#if DEBUG
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationView(true, .constant(Dummy.user))
                .environmentObject(Session())
        }
    }
}
#endif

