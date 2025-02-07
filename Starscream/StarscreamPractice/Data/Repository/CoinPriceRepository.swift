//
//  CoinPriceRepository.swift
//  Starscream
//
//  Created by SiJongKim on 2/7/25.
//

import SwiftUI
import Combine

public protocol CoinPriceRepository {
    func subscribe(symbol: String)
    func unsubscribe()

    var tradePublisher: Published<Trade?>.Publisher { get }
}

public class CoinPriceRepositoryImpl: CoinPriceRepository {
    private let webSocketClient: BinanceWebSocketClient
    private var cancellables = Set<AnyCancellable>()

    @Published private var trade: Trade? = nil
    public var tradePublisher: Published<Trade?>.Publisher { $trade }

    init(webSocketClient: BinanceWebSocketClient) {
        self.webSocketClient = webSocketClient

        // webSocketClient -> Repository 로 데이터 전달
        webSocketClient.tradePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] newTrade in
                self?.trade = newTrade
            }
            .store(in: &cancellables)
    }

    public func subscribe(symbol: String) {
        webSocketClient.connect(symbol: symbol)
    }

    public func unsubscribe() {
        webSocketClient.disconnect()
    }
}
