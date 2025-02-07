//
//  BinanceTradeDTO.swift
//  Starscream
//
//  Created by SiJongKim on 2/7/25.
//

import Foundation


struct BinanceTradeDTO: Decodable {
    let e: String
    let s: String
    let p: String
    let T: Int

    func toDomain() -> Trade {
        let priceDouble = Double(p) ?? 0.0
        let date = Date(timeIntervalSince1970: TimeInterval(T) / 1000.0)
        return Trade(symbol: s, price: priceDouble, timestamp: date)
    }
}
