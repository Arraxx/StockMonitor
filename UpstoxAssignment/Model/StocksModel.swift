//
//  StocksModel.swift
//  UpstoxAssignment
//
//  Created by Arrax on 17/02/24.
//

import Foundation

struct StocksModel : Codable, Hashable {
    var userHolding : [Data]
}

struct Data : Codable, Hashable {
    var symbol : String
    var quantity : Int
    var ltp : Double
    var avgPrice : Double
    var close : Int
    
    var currentVal : Double {
        return ltp * Double(quantity)
    }
    var investmentVal : Double {
        return avgPrice * Double(quantity)
    }
    var pAndl : Double {
        return currentVal - investmentVal
    }
}

enum StockData {
    case success(StocksModel)
    case failure(Error)
    
    var id: Int {
        switch self {
        case .success(let model):
            // Use a unique identifier for success case
            return model.userHolding.hashValue
        case .failure(let error):
            // Use a unique identifier for failure case
            return error.localizedDescription.hashValue
        }
    }
}
