//
//  Icebreakers.swift
//  Blendate
//
//  Created by Michael on 4/2/22.
//

import Foundation

enum Icebreakers: String, CaseIterable {
    case airplane = "Airplane"
    case celebrity = "Celebrity"
    case dog = "Dog"
    case dream = "DreamJob"
    case holiday = "Holiday"
    case jugle = "Jugle"
    case kareoke = "Kareoke"
    case salty = "Salty"
    case tea = "Tea"
    
    var title: String {
        switch self {
        case .airplane:
            return "Airplane Seat"
        case .celebrity:
            return "Celebrity Crush"
        case .dog:
            return "Dog Breed"
        case .dream:
            return "Absolute Dream Job"
        case .holiday:
            return "Favorite Holiday"
        case .jugle:
            return "Juggle"
        case .kareoke:
            return "Kareoke Song"
        case .salty:
            return "Sweet or Salty"
        case .tea:
            return "Coffee or Tea"
        }
    }
    
    var text: String {
        switch self {
        case .airplane:
            return "Where do you preffer to sit on the an airplane?"
        case .celebrity:
            return "Who is your celebrity crush?"
        case .dog:
            return "What is your favorite dog breed?"
        case .dream:
            return "What is your absolute dream job?"
        case .holiday:
            return "What is your favorite vacation destination?"
        case .jugle:
            return "Do you have any unique skills?"
        case .kareoke:
            return "What is your go to kareoke song?"
        case .salty:
            return "Do you preffer sweet or salty snacks?"
        case .tea:
            return "Do you drink coffee or tea in the morning?"
        }
    }
}
