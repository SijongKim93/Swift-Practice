// Presentation/CoinPriceViewModel.swift

import SwiftUI
import Combine

class CoinPriceViewModel: ObservableObject {

    private let useCase: CoinPriceStreamUseCase
    private var cancellables = Set<AnyCancellable>()

    // 뷰에서 표시할 값
    @Published var currentPrice: String = "-"
    @Published var symbol: String = "BTCUSDT"

    init(useCase: CoinPriceStreamUseCase) {
        self.useCase = useCase

        // UseCase -> ViewModel
        useCase.tradePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] trade in
                guard let self = self, let trade = trade else { return }
                self.currentPrice = String(format: "%.4f", trade.price)
            }
            .store(in: &cancellables)
    }

    func onAppear() {
        // 심볼 설정 후 스트리밍 시작
        useCase.startStreaming(symbol: symbol)
    }

    func onDisappear() {
        // 화면 벗어나면 스트리밍 중단
        useCase.stopStreaming()
    }

    func changeSymbol(to newSymbol: String) {
        // 심볼 교체 시 스트리밍 재시작
        useCase.stopStreaming()
        symbol = newSymbol
        useCase.startStreaming(symbol: symbol)
    }
}
