//
//  ScanerView.swift
//  barcodeScanerApp
//
//  Created by matvey on 24.12.2023.
//

import SwiftUI

struct ScanerCoordinator: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?
    
    func makeUIViewController(context: Context) -> ScanerVC {
        ScanerVC(scanerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    final class Coordinator: NSObject,ScannerVCDelegate{
        
        private let scannerView: ScanerCoordinator
        
        init(scannerView: ScanerCoordinator) {
            self.scannerView = scannerView
        }
        
        func didFind(barcode: String) {
            scannerView.scannedCode = barcode
        }
        
        func didSurface(error: CameraError) {
            switch error{
            case .InvalidDeviceInput:
                scannerView.alertItem = AlertContext.invalidDeviceInput
            case .invalidScanValue:
                scannerView.alertItem = AlertContext.invalidScanType
            }
        }
    }
    
}
