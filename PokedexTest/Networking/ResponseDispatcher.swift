//
//  ResponseDispatcher.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import UIKit

protocol ResponseDispatcher {
    associatedtype ResponseType: Codable
    var request: RequestTypeProtocol { get }
}

extension ResponseDispatcher {
    func execute(
        manager: NetworkManagerProtocol = NetworkManager(),
        onSuccess: @escaping (ResponseType) -> Void,
        onError: @escaping (String) -> Void
    ) {
        manager.fetchData(
            request: request,
            onSuccess: { data in
                do {
                    let response = try JSONDecoder().decode(ResponseType.self, from: data)
                    onSuccess(response)
                } catch {
                    onError(error.localizedDescription)
                }
            },
            onError: { error, description in
                onError(error?.localizedDescription ?? "")
            })
    }
    
    func execute(
        manager: NetworkManagerProtocol = NetworkManager(),
        completion: @escaping (UIImage?) -> Void
    ) {
        manager.fetchImage(
            request: request,
            completion: { data in
                guard let data  = data,
                      let image = UIImage(data: data) else {
                          completion(nil)
                          return
                      }
                completion(image)
            })
        
    }
}
