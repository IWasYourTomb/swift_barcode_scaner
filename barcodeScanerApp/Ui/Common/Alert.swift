//
//  Alert.swift
//  barcodeScanerApp
//
//  Created by matvey on 24.12.2023.
//

import SwiftUI


struct AlertItem: Identifiable{
    let id = UUID()
    let title: String
    let message: String
    let dissmissButton: Alert.Button
}

struct AlertContext{
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input", message: "Something is wrong with the camera. We are unable to capture the input", dissmissButton: .default(Text("OK")))
    static let invalidScanType = AlertItem(title: "Invalid Scan Type", message: "The value scanned is not valid. This app scans EAN-8 and EAN-13", dissmissButton: .default(Text("OK")))
}
