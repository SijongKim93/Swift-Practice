//
//  Trade.swift
//  Starscream
//
//  Created by SiJongKim on 2/7/25.
//

import Foundation

public struct Trade {
    public var symbol: String
    public var price: Double
    public var timestamp: Date

    public init(symbol: String, price: Double, timestamp: Date) {
        self.symbol = symbol
        self.price = price
        self.timestamp = timestamp
    }
}
