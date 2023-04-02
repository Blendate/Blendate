//
//  ReportButton.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/13/23.
//

import SwiftUI

struct ReportButton: View {
    @State var alert: (any ErrorAlert)?
    let uid: String?
    var name: String?
    var withName: Bool = false
    var messageEnd: String = "Only report profiles that do not meet our profile requirements"

    var reported: ()->Void
    
    var message: String {
        "Do you want to report \(name ?? "User")? "
    }
    
    
    var body: some View {
        Button {
            self.alert = ReportError(message: message+messageEnd)
        } label: {
            if withName {
                HStack {
                    Image(systemName: "exclamationmark.shield")
                        .font(.title3)
                    Text("Report \(name ?? "User")'s Profile")
                }
                .foregroundColor(.red.opacity(0.75))
            } else {
                Image(systemName: "exclamationmark.shield")
                    .font(.title2)
                    .foregroundColor(.red.opacity(0.75))
                    .padding(6)
                    .background(Color.white)
                    .clipShape(Circle())
            }

        }

        .errorAlert(error: $alert) { error in
            Button("Report", role: .destructive, action: report)
            Button("Cancel", role: .cancel){}
        }
        
    }
    
    private func report() {
        #warning("implement reporting")
        reported()
    }
    
    struct ReportError: ErrorAlert {
        var title = "Report"
        var message: String
    }
}


struct ReportButton_Previews: PreviewProvider {
    static var previews: some View {
        ReportButton(uid: "1234", name: "Michael") {
            
        }
        ReportButton(uid: "1234", name: "Michael", withName: true) {
            
        }
    }
}
