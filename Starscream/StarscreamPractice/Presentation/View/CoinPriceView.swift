// Presentation/CoinPriceView.swift

import SwiftUI

struct CoinPriceView: View {
    @ObservedObject var viewModel: CoinPriceViewModel

    var body: some View {
        VStack {
            Text("Symbol: \(viewModel.symbol)")
                .font(.headline)

            Text("Current Price: \(viewModel.currentPrice) USDT")
                .font(.largeTitle)
                .padding()

            // 심볼 교체 버튼
            HStack {
                Button("BTC/USDT") {
                    viewModel.changeSymbol(to: "BTCUSDT")
                }
                Button("ETH/USDT") {
                    viewModel.changeSymbol(to: "ETHUSDT")
                }
                Button("XRP/USDT") {
                    viewModel.changeSymbol(to: "XRPUSDT")
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
        .padding()
    }
}
