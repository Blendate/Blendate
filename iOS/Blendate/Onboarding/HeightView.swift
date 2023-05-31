//
//  HeightView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI




//#if DEBUG
//struct HeightView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreviewSignup(.height)
//        HeightView(height: .constant(49), isFilter: true)
//    }
//}
//#endif

public struct LengthFormatters {

    public static let imperialLengthFormatter: LengthFormatter = {
        let formatter = LengthFormatter()
        formatter.isForPersonHeightUse = true
        formatter.unitStyle = .short
        return formatter
    }()

}

extension Measurement where UnitType : UnitLength {

    var heightOnFeetsAndInches: String? {
        guard let measurement = self as? Measurement<UnitLength> else {
            return nil
        }
        let meters = measurement.converted(to: .meters).value
        return LengthFormatters.imperialLengthFormatter.string(fromMeters: meters)
    }

}
