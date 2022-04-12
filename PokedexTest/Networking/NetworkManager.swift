//
//  NetworkManager.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol {
    var session: NetworkSession { get set }
    func fetchData(request: RequestTypeProtocol?, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error?, String?) -> Void)
    func fetchImage(request: RequestTypeProtocol?, completion: @escaping (Data?) -> Void)
}

struct NetworkManager: NetworkManagerProtocol {
    var session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(
        request: RequestTypeProtocol?,
        onSuccess: @escaping (Data) -> Void,
        onError: @escaping (Error?, String?) -> Void
    ) {
        guard let request = request,
              let urlRequest = request.urlRequest else { return }

        session.execute(from: urlRequest, completionHandler: { (data, response, error) in
            guard let dataResponse = data else {
                onError(error, error.debugDescription)
                return
            }
            onSuccess(dataResponse)
        })
    }
    
    func fetchImage(
        request: RequestTypeProtocol?,
        completion: @escaping (Data?) -> Void
    ) {
        guard let url = request?.url else { return }
        session.execute(from: url) { data, response, error in
            guard let data  = data else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
