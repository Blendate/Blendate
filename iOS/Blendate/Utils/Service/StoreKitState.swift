////
////  StoreKitState.swift
////  Blendate
////
////  Created by Michael Wilkowski on 2/22/23.
////
//
//import Foundation
//import StoreKit
//import Combine
//
//final class AppState: NSObject, ObservableObject {
//  @Published var products = [SKProduct]()
//  @Published var paymentInProgress = false
//
//  func loadProducts() {
//    let subcriptionIds = Set(["pro.monthly", "pro.yearly"])
//    let request = SKProductsRequest(productIdentifiers: subcriptionIds)
//    request.delegate = self
//    request.start()
//  }
//  
//  func buyProduct(_ product: SKProduct) {
//    paymentInProgress = true
//    let payment = SKPayment(product: product)
//    SKPaymentQueue.default().add(payment)
//  }
//}
//
//extension AppState: SKProductsRequestDelegate {
//  func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//    DispatchQueue.main.async { [weak self] in
//      self?.products = response.products
//    }
//  }
//
//  func request(_ request: SKRequest, didFailWithError error: Error) {
//    print("Error getting products \(error)")
//  }
//}
//
//extension AppState: SKPaymentTransactionObserver {
//  func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//    for transaction in transactions {
//      switch transaction.transactionState {
//      case .purchased:
//        print("purchased")
//        queue.finishTransaction(transaction)
//
//        storeReceipt {
//          self.paymentInProgress = false
//        }
//
//      case .failed:
//        print(transaction.error as Any)
//        queue.finishTransaction(transaction)
//        paymentInProgress = false
//
//      case .purchasing:
//        print("purchasing")
//        paymentInProgress = true
//
//      default:
//        print("something else")
//        paymentInProgress = false
//      }
//    }
//  }
//
//  func storeReceipt(done: @escaping () -> Void) {
//    if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL, FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {
//      do {
//        let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
//        let receiptString = receiptData.base64EncodedString(options: [])
//
//        let functions = CloudFunction()
//        functions.validateReceipt(receipt: receiptString) {
//          done()
//        }
//      } catch {
//        print("Couldn't read receipt data with error: " + error.localizedDescription)
//      }
//    }
//  }
//}
