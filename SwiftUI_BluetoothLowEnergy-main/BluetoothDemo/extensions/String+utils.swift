//
//  String+utils.swift
//  BluetoothDemo
//
//  Created by Itsuki on 2025/01/29.
//

import SwiftUI
import CoreBluetooth

extension String {
    var cbUUIDs: [CBUUID]?  {
        if self.isEmpty {
            return nil
        }
        let array = self.split(separator: ",")
        let uuids: [UUID?] = array.map({UUID(uuidString: $0.trimmingCharacters(in: .whitespacesAndNewlines))})
        let nonNil = uuids.filter({$0 != nil}).map({$0!})
        return nonNil.map({CBUUID(nsuuid: $0)})
    }
    
    var data: Data? {
        self.data(using: .utf8)
    }
}
