//
//  ContentView.swift
//  BluetoothDemo
//
//  Created by Itsuki on 2025/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 32) {
            
            HStack(spacing: 32) {
                ForEach(0..<6, id: \.self) { _ in
                    Image(systemName: "personalhotspot.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                }
            }
            .padding(.vertical, 24)
            
            VStack(spacing: 32) {
                NavigationLink(destination: {
                    PeripheralView()
                    
                }, label: {
                    Text("I am Peripheral!")
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.black))
                })
                
                NavigationLink(destination: {
                    CentralView()
                    
                }, label: {
                    Text("Find and Connect!")
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.black))
                })
            }
            .font(.headline)
            .fixedSize(horizontal: true, vertical: true)
            
    
            HStack(spacing: 32) {
                ForEach(0..<6, id: \.self) { _ in
                    Image(systemName: "personalhotspot.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                }
            }
            .padding(.vertical, 24)

        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        ContentView()

    }
}
