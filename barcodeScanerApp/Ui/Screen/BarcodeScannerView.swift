//
//  ContentView.swift
//  barcodeScanerApp
//
//  Created by matvey on 24.12.2023.
//

import SwiftUI


struct BarcodeScannerView: View {
    
    @State private var scannedCode = ""
    @State private var alertItem: AlertItem?
    
    var body: some View {
        NavigationStack{
            VStack{
                ScanerCoordinator(scannedCode: $scannedCode, alertItem: $alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode:", systemImage: "barcode")
                    .font(.title)
                
                Text(scannedCode.isEmpty ? "Not yet scanned" : scannedCode)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(scannedCode.isEmpty ? .red : .green  )
                    .padding()
            }
            .navigationTitle("Barcode Scaner")
            .alert(item: $alertItem){alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dissmissButton)
            }
        }
       
    }
}

#Preview {
    BarcodeScannerView()
}
