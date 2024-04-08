//
//  BarcodeScannerViewModel.swift
//  barcodeScanerApp
//
//  Created by matvey on 24.12.2023.
//

import Foundation
import SwiftUI

final class BarcodeScannerViewModel: ObservableObject{
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    var statusTextChecker: String{
        scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
    }
    
    var statusColorChecker: Color{
        scannedCode.isEmpty ? .red : .green
    }
}
