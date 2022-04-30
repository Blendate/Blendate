//
//  LocalFileManager.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import Foundation
import UIKit

class LocalFileService {
    static let instance = LocalFileService()
    private let kUser = "user_store"

    private init(){}
        
    private func createIfMissingFolder(named: String){
        guard let url = getURL(folder: named) else {return}
        if !FileManager.default.fileExists(atPath: named){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory folder name: \(named). \(error)")
            }
        }
    }
    
    private func getURL(folder: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
            else {return nil}
        return url.appendingPathComponent(folder)
    }
    
    private func getURL(named name: String, in folder: String) -> URL? {
        guard let folderURL = getURL(folder: folder)
            else {return nil}
        return folderURL.appendingPathComponent(name + ".png")
    }
}

//MARK: UserDefaults
extension LocalFileService {
    
    func store(user: User) throws {
        let defaults = UserDefaults.standard
        do {
            let data = try JSONEncoder().encode(user)
            defaults.set(data, forKey: kUser)
        } catch {
            throw ErrorInfo(errorDescription: "Storage Error", failureReason: "There was an error accessing your device's storage", recoverySuggestion: "Try again")
        }
        
    }
    
    func retreiveUser() throws -> User {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: kUser)
            else {
                throw ErrorInfo(errorDescription: "Storage Error", failureReason: "There was an error accessing your device's storage", recoverySuggestion: "Try again")
            }
        
        do {
            let wallets = try JSONDecoder().decode(User.self, from: data)
            return wallets
        } catch {
            throw ErrorInfo(errorDescription: "Storage Error", failureReason: "There was an error accessing your device's storage", recoverySuggestion: "Try again")
        }
    }
}
