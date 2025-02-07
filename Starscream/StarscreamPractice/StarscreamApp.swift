// MyCoinApp.swift (메인 엔트리포인트)
import SwiftUI

@main
struct MyCoinApp: App {

    var body: some Scene {
        WindowGroup {
            // 1) WebSocket Client
            let webSocketClient = BinanceWebSocketClient()

            // 2) Repository
            let repository = CoinPriceRepositoryImpl(webSocketClient: webSocketClient)

            // 3) UseCase
            let useCase = CoinPriceStreamUseCaseImpl(repository: repository)

            // 4) ViewModel
            let viewModel = CoinPriceViewModel(useCase: useCase)

            // 5) SwiftUI View
            CoinPriceView(viewModel: viewModel)
        }
    }
}
