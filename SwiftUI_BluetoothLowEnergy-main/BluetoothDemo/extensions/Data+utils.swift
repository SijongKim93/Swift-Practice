//
//  Data+utils.swift
//  BluetoothDemo
//
//  Created by Itsuki on 2025/01/29.
//

import SwiftUI

extension Data {
    var string: String {
        String(data: self, encoding: .utf8) ?? ""
    }
}
