//
//  APIRouter.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 13.12.2022.
//

import Foundation


protocol Endpoint {
    var path: String  { get }
    var queryItems: [URLQueryItem] { get }
}


extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.coingecko.com"
        components.path = "/api/v3/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}


enum APIRouter: Endpoint {
    case getCoinsData
    case getMarketData
    case getCoinDetailData(id: String)
    
    
    // MARK: Path
    var path: String {
        switch self {
        case .getCoinsData:
            return "coins/markets"
        case .getMarketData:
            return "global"
        case .getCoinDetailData(let id):
            return "coins/\(id)"
        }
    }
    
    // MARK: URLQueryItem
    var queryItems: [URLQueryItem] {
        switch self {
        case .getCoinsData:
            return CoinRequest().query
        case .getCoinDetailData:
            return CoinDetailRequest().query
        default: return []

        }
    }
}
