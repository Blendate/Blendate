//
//  LocalService.swift
//  Blendate
//
//  Created by Michael on 1/10/22.
//

import Foundation

struct LocalService {
        
//    func fileUser() async throws -> User {
//        guard let data = readLocalFile() else {throw FirebaseError.decode}
//        let decodedData = try JSONDecoder().decode(UserReponse.self, from: data)
//        let user = User(rawUser: decodedData.data.user)// networkUser
//        return user
//    }
    
//    static func mockUsers() async throws -> [User] {
//        guard let data = readLocalFile() else {throw FirebaseError.decode}
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
//        let decodedData = try decoder.decode(MockResponse.self, from: data)
////        let user = User(rawUser: decodedData.data.user)// networkUser
//        let mockUsers = decodedData.data
//        var users: [User] = []
//        for u in mockUsers {
//            let user = User(mockUser: u)
//            users.append(user)
//        }
//        return users
//    }
    
    private static func readLocalFile() -> Data? {
        guard let fileUrl = Bundle.main.url(forResource: "Blendate", withExtension: "json") else {
            print("File could not be located at the given url")
            return nil
        }

        do {
            // Get data from file
            let data = try Data(contentsOf: fileUrl)

            return data

            // Print result
        } catch {
            // Print error if something went wrong
            print("Error: \(error)")
            return nil
        }
    }

}

//extension LocalService {
//    static func uploadMock() async {
//        guard let mockUsers = try? await LocalService.mockUsers() else {return}
//        
//        
//        for user in mockUsers {
//            do {
//                try AuthService.createDoc(from: user)
//            } catch {
//                
//            }
//        }
//        
//    }
//}

