//
//  TransactionClient.swift
//  TinyBank
//
//  Created by Callum Boddy on 05/07/2018.
//  Copyright © 2018 Callum Boddy. All rights reserved.
//

import Foundation


/// mock transaction api completion with contains a generic Result object of type Transaction
typealias TransactionCompletion = (_ result: Result<[Transaction]>) -> ()


/// enumeration to track errors form the search api
///
/// - error: fallback generic error of least specificity
enum TransactionError: Error {
    case invalidEndpoint
    case incompatableURL
    case invalidData
    case error

    //TODO: add more transaction error cases and handle appropriately
}

/// the TransactionClient in an HTTP api client from interacting with the mock transaction api.
class TransactionCient {

    // MARK - Instance Variables

    let session: URLSession
    let endpoint: String

    // MARK - Initialisers

    // TODO: extract constants elsewhere
    init(session: URLSession = URLSession.shared, endpoint: String = "http://www.mocky.io/v2/5b33bdb43200008f0ad1e256") {
        self.session = session
        self.endpoint = endpoint
    }

    /// communcates with the transaction api given a query asyncronously and will return a completion with Transaction or an Error
    ///
    /// - Parameters:
    ///   - completion: a generic Result object which contains and array of Transaction or an Error
    func fetch(completion: @escaping TransactionCompletion) {

        guard let urlComponenents = URLComponents(string: endpoint) else {
            completion(.failure(TransactionError.invalidEndpoint))
            return
        }

        guard let url = urlComponenents.url else {
            completion(.failure(TransactionError.incompatableURL))
            return
        }

        // create and start task with url session
        session.dataTask(with: URLRequest(url: url)) { (data, response, error) in

            // ensure valid data
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(TransactionError.invalidData))
                    return
                }
                return
            }

            // ensure no error present
            if let _ = error {
                completion(.failure(TransactionError.error))
                return
            }

            // parse data & create Transaction objects
            let transactions: [Transaction] = Parser.from(data: data, key: "data")

            // return products, executed on the main thread (possibly parameterise this an option in the future)
            DispatchQueue.main.async { completion(.success(transactions)) }
            }.resume()
    }
}


