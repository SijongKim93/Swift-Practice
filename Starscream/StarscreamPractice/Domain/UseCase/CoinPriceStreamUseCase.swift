//
//  CoinPriceStreamUseCase.swift
//  Starscream
//
//  Created by SiJongKim on 2/7/25.
//

import SwiftUI
import Combine

public protocol CoinPriceStreamUseCase {
    func startStreaming(symbol: String)
    func stopStreaming()

    var tradePublisher: Published<Trade?>.Publisher { get }
}


public class CoinPriceStreamUseCaseImpl: CoinPriceStreamUseCase {

    private let repository: CoinPriceRepository
    private var cancellables = Set<AnyCancellable>()

    @Published private var latestTrade: Trade? = nil
    public var tradePublisher: Published<Trade?>.Publisher { $latestTrade }

    public init(repository: CoinPriceRepository) {
        self.repository = repository

        repository.tradePublisher
            .sink { [weak self] trade in
                self?.latestTrade = trade
            }
            .store(in: &cancellables)
    }

    public func startStreaming(symbol: String) {
        repository.subscribe(symbol: symbol)
    }

    public func stopStreaming() {
        repository.unsubscribe()
    }
}
