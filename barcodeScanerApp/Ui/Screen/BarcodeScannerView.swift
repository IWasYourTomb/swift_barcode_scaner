//
//  ContentView.swift
//  barcodeScanerApp
//
//  Created by matvey on 24.12.2023.
//

import SwiftUI


struct BarcodeScannerView: View {
    @StateObject private var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                ScanerCoordinator(scannedCode: $viewModel.scannedCode, alertItem: $viewModel.alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode:", systemImage: "barcode")
                    .font(.title)
                
                BarcodeScannerText(text: viewModel.statusTextChecker, color: viewModel.statusColorChecker)
            }
            .navigationTitle("Barcode Scaner")
            .alert(item: $viewModel.alertItem){alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dissmissButton)
            }
        }
       
    }
}

#Preview {
    BarcodeScannerView()
}
