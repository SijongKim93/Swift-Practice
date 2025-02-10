//
//  BluetoothDemoApp.swift
//  BluetoothDemo
//
//  Created by Itsuki on 2025/01/25.
//

import SwiftUI

@main
struct BluetoothDemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.gray.opacity(0.2))
            }
        }
    }
}
