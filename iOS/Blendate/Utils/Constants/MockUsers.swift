//
//  MockUsers.swift
//  Blendate
//
//  Created by Michael on 11/23/22.
//

import SwiftUI

struct MockUsers: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                getUsers()
            }
    }
    
    func getUsers(){
        if let filePath = Bundle.main.path(forResource: "BlendateFirebase", ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            do {
                let data = try Data(contentsOf: fileUrl)
                let results = try JSONDecoder().decode([User].self, from: data)
                print(results.count)
            } catch {
                print(error)
            }
        }
    }
    

}

struct MockUsers_Previews: PreviewProvider {
    static var previews: some View {
        MockUsers()
    }
}
