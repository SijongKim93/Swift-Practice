//
//  BinanceWebSocketClient.swift
//  Starscream
//
//  Created by SiJongKim on 2/7/25.
//

import SwiftUI
import Combine
import Starscream

class BinanceWebSocketClient: NSObject, WebSocketDelegate {

    private var socket: WebSocket?
    @Published var currentTrade: Trade? = nil

    var tradePublisher: Published<Trade?>.Publisher {
        $currentTrade
    }

    func connect(symbol: String) {
        let urlString = "wss://stream.binance.com:9443/ws/\(symbol.lowercased())@trade"
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 5

        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }

    func disconnect() {
        socket?.disconnect()
    }

    func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {

        switch event {
        case .connected:
            print("Connected")

        case .disconnected(let reason, let code):
            print("Disconnected: \(reason) with code: \(code)")

        case .text(let text):
            parseText(text)

        case .binary(_):
            break

        case .error(let error):
            print("Error: \(String(describing: error))")
            
        case .ping(_), .pong(_), .viabilityChanged(_), .reconnectSuggested(_), .cancelled:
            break

        case .peerClosed:
            break
        }
    }

    private func parseText(_ text: String) {
        guard let data = text.data(using: .utf8) else { return }
        do {
            let dto = try JSONDecoder().decode(BinanceTradeDTO.self, from: data)
            let domainTrade = dto.toDomain()

            DispatchQueue.main.async {
                self.currentTrade = domainTrade
            }
        } catch {
            print("Error")
        }
    }

    
}


