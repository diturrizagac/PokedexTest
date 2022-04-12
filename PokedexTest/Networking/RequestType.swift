//
//  Endpoint.swift
//  PokedexTest
//
//  Created by Diego Raul Iturrizaga Casas on 9/04/22.
//

import Foundation

protocol RequestTypeProtocol {
    var urlString: String { get set }
    var path: String? { get set }
    var query: String? { get set }
    var urlRequest: URLRequest? { get }
    var url: URL? { get }
}

extension RequestTypeProtocol {
    var url: URL? {
        guard let url = URL(string: urlString + (path ?? "") + (query ?? "")) else { return nil }
        return url
    }
    
    var urlRequest: URLRequest? {
        guard let url = url else { return nil }
        return URLRequest(url: url)
    }
}

struct RequestType: RequestTypeProtocol {
    var urlString: String
    var path: String?
    var query: String?
    
    init (
        urlString: String,
        path: String?,
        query: String?
    ) {
        self.urlString = urlString
        self.path = path
        self.query = query
    }
}
