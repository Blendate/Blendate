//
//  PurchaseLikesView.swift
//  Blendate
//
//  Created by Michael on 11/30/22.
//

import SwiftUI

struct PurchaseLikesView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var purchaseManager: StoreManager
    @Binding var settings: User.Settings
    
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .font(.largeTitle)
                .foregroundColor(Color.Purple)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .padding(.top)
            Text(Self.Attention)
                .font(.title.weight(.bold))
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .foregroundColor(.white)
            Text(Self.SuperLike)
                .multilineTextAlignment(.center)
                .font(.footnote.weight(.semibold))
                .foregroundColor(.white)
            ForEach(purchaseManager.products.sorted(by: {$0.price < $1.price})) { product in
                if product.isLike {
                    Cell(settings: $settings, product: product)
                }
            }
            .padding(.horizontal, 32)
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.Purple)
        .presentationDetents([.medium])
    }
}

import StoreKit
extension PurchaseLikesView {
    struct Cell: View {
        @EnvironmentObject var purchaseManager: StoreManager
        @EnvironmentObject var session: UserViewModel
        
        @Binding var settings: User.Settings
        @State var error: ErrorAlert?
        let product: Product
        
        var body: some View {
            AsyncButton(action: purchase) {
                HStack {
                    Spacer()
                    VStack {
                        HStack {
                            Text(product.displayPrice)
                                .foregroundColor(.primary)
                            Text(product.displayName)
                                .foregroundColor(.Blue)
                        }.fontWeight(.bold)
                        Text(product.displayUnitPrice ?? "")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                    Spacer()
                }
                .background(Color.white)
                .clipShape(Capsule(style: .continuous))
                .shadow(radius: 5)

            }
            .errorAlert(error: $error) { error in
                AsyncButton("Try Again", action: purchase)
                Button("Cancel"){}
            }
        }
        
        private func purchase() async {
            do {
                try await purchaseManager.purchase(product)
                if let likes = product.likeCount {
                    settings.premium.superLikes += likes
                    try session.save()
                } else {
                    self.error = StoreManager.Error(message: "There was an error saving your purchase on the server, please contact support with ID \n \(session.uid)")
                }

            } catch {
                self.error = StoreManager.Error()
                print(error.localizedDescription)
            }
        }
    }
}
extension Product {
    var isLike: Bool {
        self.displayName.contains("Like")
    }
    
    var likeCount: Int? {
        guard isLike else {return nil}
        let string = self.id.filter { "0"..."9" ~= $0 }
        return Int(string)
    }
    
    var displayUnitPrice: String? {
        guard let likeCount else {return nil}
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let number = formatter.number(from: self.displayPrice)
        let decimal = number?.decimalValue
        guard let decimal else {return nil}
        let unitPrice = decimal / Decimal(likeCount)
        let string = "\(unitPrice)".prefix(4)
        return "$\(string) Each"
    }
    

}


//
//struct PurchaseLikesView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            Spacer()
//        }
//        .sheet(isPresented: .constant(true)) {
//            PurchaseLikesView()
//                .presentationDetents([.medium])
//        }
//    }
//}
