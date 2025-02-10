//
//  CB+utils.swift
//  BluetoothDemo
//
//  Created by Itsuki on 2025/01/29.
//

import SwiftUI
import CoreBluetooth

extension CBCharacteristicProperties {
    var string: String {
        var results: [String] = []
        for option: CBCharacteristicProperties in [.read, .writeWithoutResponse, .write, .notify] {
            guard self.contains(option) else { continue }
            switch option {
            case .read: results.append("read")
            case .writeWithoutResponse, .write:
                if self.contains(.writeWithoutResponse) {
                    results.append("write(without response)")
                } else {
                    results.append("write")
                }
            case .notify: results.append("notify")
            default: fatalError()
            }
        }
        
        if results.isEmpty {
            return "(none)"
        }
        
        return results.joined(separator: ", ")
    }
}


extension CBCharacteristic {
    var userDescription: String {
        if self.descriptors == nil || self.descriptors!.isEmpty {
            return ""
        }
        let descriptors = self.descriptors!
        for descriptor in descriptors {
            if descriptor.uuid == CBUUID(string: CBUUIDCharacteristicUserDescriptionString) {
                return descriptor.value as? String ?? ""
            }
        }
        return ""
    }
}
